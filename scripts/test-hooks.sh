#!/usr/bin/env bash
# Exercises the four hook scripts outside a session, with a fake $HOME and a
# fake `claude` on PATH — no API calls, no writes outside the temp dir.
# Runs the EN copies; the PT ones are byte-identical (check-parity enforces).
cd "$(dirname "$0")/.." || exit 1
REPO=$PWD
G="$REPO/skills/concise/hooks/credit-guard.sh"
N="$REPO/skills/concise/hooks/notices.sh"
U="$REPO/skills/concise/hooks/self-update.sh"
I="$REPO/skills/concise/hooks/inject-core.sh"
FH="${TMPDIR:-/tmp}/concise-hooktest.$$"; rm -rf "$FH"; mkdir -p "$FH/.claude"
trap 'rm -rf "$FH"' EXIT
pass=0; fail=0
t () { # nome, esperado(deny|allow), stdin
  out=$(printf '%s' "$3" | HOME="$FH" bash "$G" "MOTIVO" .concise-no-credit-guard)
  got=allow; case "$out" in *permissionDecision*) got=deny;; esac
  if [ "$got" = "$2" ]; then pass=$((pass+1)); printf 'ok    %-46s %s\n' "$1" "$got"
  else fail=$((fail+1)); printf 'FALHA %-46s esperado=%s obtido=%s\n' "$1" "$2" "$got"; fi
}
# a string de credito e montada em runtime para nao aparecer literal aqui
CRED="Co-Authored-By: Cla""ude <noreply@anthropic.com>"
GEN="Genera""ted with [Cla""ude Code](https://claude.com)"

t "commit simples com trailer"           deny  "{\"command\":\"git commit -m 'fix\n\n$CRED'\"}"
t "corrente composta com trailer"        deny  "{\"command\":\"git add -A && git commit -m 'x\n$CRED' && git push\"}"
t "git -C outro-dir commit"              deny  "{\"command\":\"git -C /tmp/repo commit -m 'x\n$CRED'\"}"
t "gh pr create com generated with"      deny  "{\"command\":\"gh pr create --body 'ok\n$GEN'\"}"
t "gh pr edit"                           deny  "{\"command\":\"gh pr edit 3 --body '$GEN'\"}"
t "gh issue comment"                     deny  "{\"command\":\"gh issue comment 1 --body '$CRED'\"}"
t "gh release create --notes"            deny  "{\"command\":\"gh release create v1 --notes '$GEN'\"}"
t "commit limpo"                         allow "{\"command\":\"git commit -m 'fix the filter'\"}"
t "grep mencionando a string"            allow "{\"command\":\"grep -r '$CRED' docs/\"}"
t "cat de arquivo qualquer"              allow "{\"command\":\"cat notes.md\"}"

# mensagem vinda de arquivo (-F): o furo que a auditoria apontou
printf 'fix\n\n%s\n' "$CRED" > "$FH/msg.txt"
t "git commit -F arquivo com credito"    deny  "{\"command\":\"git commit -F $FH/msg.txt\"}"
printf 'fix limpo\n' > "$FH/ok.txt"
t "git commit -F arquivo limpo"          allow "{\"command\":\"git commit -F $FH/ok.txt\"}"

# opt-out e escape hatch
touch "$FH/.claude/.concise-no-credit-guard"
t "opt-out por flag"                     allow "{\"command\":\"git commit -m '$CRED'\"}"
rm "$FH/.claude/.concise-no-credit-guard"
out=$(printf '%s' "{\"command\":\"git commit -m '$CRED'\"}" | HOME="$FH" CONCISE_ALLOW_CREDIT=1 bash "$G" "M" .concise-no-credit-guard)
if [ -z "$out" ]; then pass=$((pass+1)); echo "ok    escape hatch CONCISE_ALLOW_CREDIT"; else fail=$((fail+1)); echo "FALHA escape hatch"; fi

echo "--- notices"
out=$(HOME="$FH" bash "$N" concise "BEM-VINDO" "falhou, rode %s")
case "$out" in *systemMessage*BEM-VINDO*) pass=$((pass+1)); echo "ok    boas-vindas emite systemMessage";; *) fail=$((fail+1)); echo "FALHA boas-vindas: $out";; esac
out=$(HOME="$FH" bash "$N" concise "BEM-VINDO" "falhou, rode %s")
[ -z "$out" ] && { pass=$((pass+1)); echo "ok    segunda sessao silencia"; } || { fail=$((fail+1)); echo "FALHA segunda sessao: $out"; }
printf 'concise updated from 1.12.0 to 1.13.0' > "$FH/.claude/.concise-update-note"
out=$(HOME="$FH" bash "$N" concise "BV" "falhou %s")
case "$out" in *"1.13.0"*) pass=$((pass+1)); echo "ok    anuncia versao aplicada";; *) fail=$((fail+1)); echo "FALHA anuncio: $out";; esac
[ -f "$FH/.claude/.concise-update-note" ] && { fail=$((fail+1)); echo "FALHA nota nao foi limpa"; } || { pass=$((pass+1)); echo "ok    nota limpa apos exibir"; }

echo "--- inject-core"
out=$(HOME="$FH" CLAUDE_PLUGIN_ROOT="$REPO/skills/concise" bash "$I" concise-core-override.md core.md | head -1)
case "$out" in "Response style"*) pass=$((pass+1)); echo "ok    injeta core embarcado";; *) fail=$((fail+1)); echo "FALHA core: $out";; esac
printf 'NUCLEO CUSTOM\n' > "$FH/.claude/concise-core-override.md"
out=$(HOME="$FH" CLAUDE_PLUGIN_ROOT="$REPO/skills/concise" bash "$I" concise-core-override.md core.md)
[ "$out" = "NUCLEO CUSTOM" ] && { pass=$((pass+1)); echo "ok    override vence"; } || { fail=$((fail+1)); echo "FALHA override: $out"; }

echo "--- self-update (claude fake)"
mkdir -p "$FH/bin"
printf '#!/usr/bin/env bash\necho chamada >> "%s/calls.log"\n[ "$1" = "plugin" ] && [ "$2" = "update" ] && echo "Plugin updated from 1.12.0 to 1.13.0 for scope user."\nexit 0\n' "$FH" > "$FH/bin/claude"
chmod +x "$FH/bin/claude"; rm -f "$FH/calls.log"
HOME="$FH" PATH="$FH/bin:$PATH" bash "$U" concise
n1=$(wc -l < "$FH/calls.log" 2>/dev/null | tr -d ' ')
HOME="$FH" PATH="$FH/bin:$PATH" bash "$U" concise
n2=$(wc -l < "$FH/calls.log" | tr -d ' ')
[ "$n1" = "2" ] && [ "$n2" = "2" ] && { pass=$((pass+1)); echo "ok    throttle diario (2 chamadas, 2a sessao zero)"; } || { fail=$((fail+1)); echo "FALHA throttle: n1=$n1 n2=$n2"; }
grep -q "1.13.0" "$FH/.claude/.concise-update-note" 2>/dev/null && { pass=$((pass+1)); echo "ok    grava nota de versao"; } || { fail=$((fail+1)); echo "FALHA nota de versao"; }
[ -d "$FH/.claude/.concise-update-lock" ] && { fail=$((fail+1)); echo "FALHA lock ficou para tras"; } || { pass=$((pass+1)); echo "ok    lock liberado"; }
# falha permanente: carimba mesmo assim (nao repete toda sessao)
rm -f "$FH/.claude/.concise-update-stamp" "$FH/calls.log"
printf '#!/usr/bin/env bash\necho chamada >> "%s/calls.log"\nexit 1\n' "$FH" > "$FH/bin/claude"; chmod +x "$FH/bin/claude"
HOME="$FH" PATH="$FH/bin:$PATH" bash "$U" concise
[ -s "$FH/.claude/.concise-update-stamp" ] && { pass=$((pass+1)); echo "ok    falha tambem carimba"; } || { fail=$((fail+1)); echo "FALHA falha nao carimbou"; }
[ -s "$FH/.claude/.concise-update-failed" ] && { pass=$((pass+1)); echo "ok    marca falha para aviso semanal"; } || { fail=$((fail+1)); echo "FALHA marcador de falha"; }
# opt-out do self-update
rm -f "$FH/.claude/.concise-update-stamp" "$FH/calls.log"; touch "$FH/.claude/.concise-no-self-update"
HOME="$FH" PATH="$FH/bin:$PATH" bash "$U" concise
[ ! -s "$FH/calls.log" ] && { pass=$((pass+1)); echo "ok    opt-out do self-update"; } || { fail=$((fail+1)); echo "FALHA opt-out self-update"; }

echo "===== $pass ok, $fail falhas"
[ "$fail" -eq 0 ]
