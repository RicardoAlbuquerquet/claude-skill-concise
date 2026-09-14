#!/usr/bin/env bash
# Exercises the hook scripts outside a session, with a fake $HOME and a
# fake `claude` on PATH — no API calls, no writes outside the temp dir.
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
# O output style forcado ja leva o nucleo no system prompt; imprimir de novo no
# inicio da sessao pagava o mesmo texto duas vezes. So com CONCISE_INJECT_CORE=1.
out=$(HOME="$FH" CLAUDE_PLUGIN_ROOT="$REPO/skills/concise" bash "$I" concise-core-override.md core.md)
[ -z "$out" ] && { pass=$((pass+1)); echo "ok    nucleo embarcado nao sai duas vezes"; } || { fail=$((fail+1)); echo "FALHA nucleo duplicado: $(printf '%s' "$out" | head -1)"; }
out=$(HOME="$FH" CONCISE_INJECT_CORE=1 CLAUDE_PLUGIN_ROOT="$REPO/skills/concise" bash "$I" concise-core-override.md core.md | head -1)
case "$out" in "Response style"*) pass=$((pass+1)); echo "ok    CONCISE_INJECT_CORE=1 devolve o nucleo";; *) fail=$((fail+1)); echo "FALHA CONCISE_INJECT_CORE: $out";; esac
printf 'NUCLEO CUSTOM\n' > "$FH/.claude/concise-core-override.md"
out=$(HOME="$FH" CLAUDE_PLUGIN_ROOT="$REPO/skills/concise" bash "$I" concise-core-override.md core.md)
[ "$out" = "NUCLEO CUSTOM" ] && { pass=$((pass+1)); echo "ok    override vence"; } || { fail=$((fail+1)); echo "FALHA override: $out"; }

# a linha de plataforma: o rotulo do bloco tem que ser o shell de quem cola
IC () { HOME="$FH" CONCISE_OS="$1" CLAUDE_PLUGIN_ROOT="$REPO/skills/concise" bash "$I" concise-core-override.md core.md "FENCE powershell" "FENCE macos" "FENCE linux"; }
ic () { # nome, CONCISE_OS, trecho esperado na ultima linha
  out=$(IC "$2" | tail -1)
  case "$out" in *"$3"*) pass=$((pass+1)); echo "ok    $1";;
                 *) fail=$((fail+1)); echo "FALHA $1: $out";; esac
}
ic "windows pede powershell"       windows powershell
ic "macos pede bash"               macos   macos
ic "linux pede bash"               linux   linux
ic "os desconhecido cai em linux"  freebsd linux

# a linha vem depois do override, porque e fato da maquina e nao estilo
out=$(IC windows)
case "$out" in "NUCLEO CUSTOM"*powershell*) pass=$((pass+1)); echo "ok    plataforma sobrevive ao override";;
               *) fail=$((fail+1)); echo "FALHA override+plataforma: $out";; esac

# hooks.json antigo, sem os tres argumentos: nao imprime linha e nao falha
out=$(HOME="$FH" CONCISE_OS=windows CLAUDE_PLUGIN_ROOT="$REPO/skills/concise" bash "$I" concise-core-override.md core.md; echo "rc=$?")
case "$out" in "NUCLEO CUSTOM"*"rc=0") pass=$((pass+1)); echo "ok    sem argumentos nao quebra";;
               *) fail=$((fail+1)); echo "FALHA sem argumentos: $out";; esac

# sem override, a sessao recebe so a linha da plataforma, sem linha em branco antes
rm -f "$FH/.claude/concise-core-override.md"
out=$(IC macos)
[ "$out" = "FENCE macos" ] && { pass=$((pass+1)); echo "ok    sem override sai so a linha da plataforma"; } || { fail=$((fail+1)); echo "FALHA so a plataforma: $out"; }

echo "--- self-update (claude fake)"
mkdir -p "$FH/bin"
printf '#!/usr/bin/env bash\necho chamada >> "%s/calls.log"\n[ "$1" = "plugin" ] && [ "$2" = "update" ] && echo "Plugin updated from 1.12.0 to 1.13.0 for scope user."\nexit 0\n' "$FH" > "$FH/bin/claude"
chmod +x "$FH/bin/claude"; rm -f "$FH/calls.log"
(cd "$FH" && HOME="$FH" PATH="$FH/bin:$PATH" bash "$U" concise)
n1=$(wc -l < "$FH/calls.log" 2>/dev/null | tr -d ' ')
(cd "$FH" && HOME="$FH" PATH="$FH/bin:$PATH" bash "$U" concise)
n2=$(wc -l < "$FH/calls.log" | tr -d ' ')
[ "$n1" = "2" ] && [ "$n2" = "2" ] && { pass=$((pass+1)); echo "ok    throttle diario (2 chamadas, 2a sessao zero)"; } || { fail=$((fail+1)); echo "FALHA throttle: n1=$n1 n2=$n2"; }
# dentro do repo do proprio marketplace o carimbo do dia nao segura
(cd "$REPO" && HOME="$FH" PATH="$FH/bin:$PATH" bash "$U" concise)
n3=$(wc -l < "$FH/calls.log" | tr -d ' ')
[ "$n3" = "4" ] && { pass=$((pass+1)); echo "ok    no repo do marketplace ignora o carimbo"; } || { fail=$((fail+1)); echo "FALHA bypass no repo: n3=$n3"; }
# e tambem num subdiretorio do repo — a raiz e resolvida via git
(cd "$REPO/skills/concise" && HOME="$FH" PATH="$FH/bin:$PATH" bash "$U" concise)
n3b=$(wc -l < "$FH/calls.log" | tr -d ' ')
[ "$n3b" = "6" ] && { pass=$((pass+1)); echo "ok    subdiretorio do repo tambem ignora o carimbo"; } || { fail=$((fail+1)); echo "FALHA bypass em subdir: n3b=$n3b"; }
# e um repo qualquer continua respeitando o carimbo
mkdir -p "$FH/outro"
(cd "$FH/outro" && HOME="$FH" PATH="$FH/bin:$PATH" bash "$U" concise)
n4=$(wc -l < "$FH/calls.log" | tr -d ' ')
[ "$n4" = "6" ] && { pass=$((pass+1)); echo "ok    fora do repo o carimbo continua valendo"; } || { fail=$((fail+1)); echo "FALHA carimbo fora do repo: n4=$n4"; }
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

echo "--- stop-audit (extra, opt-in)"
SA="$REPO/extras/stop-audit/stop-audit.sh"
SAD="$FH/sa"; mkdir -p "$SAD/bin"
{ echo "#!/usr/bin/env bash"
  echo 'shift; printf "%s" "$1" > "$CAPTURE"; echo "$FAKE_VERDICT"'; } > "$SAD/bin/claude"
chmod +x "$SAD/bin/claude"
printf '{"type":"assistant","message":{"content":[{"type":"text","text":"resposta de teste"}]}}
' > "$SAD/tr.jsonl"
sa () { echo "{\"transcript_path\":\"$SAD/tr.jsonl\"}" | CAPTURE="$SAD/prompt.txt" FAKE_VERDICT="$1" CONCISE_CORE="$2" PATH="$SAD/bin:$PATH" HOME="$FH" bash "$SA"; }

# o auditor julga contra o nucleo embarcado, nao contra uma copia que envelhece
rm -f "$SAD/prompt.txt"
out=$(sa "linha ruim" "$REPO/skills/concise/hooks/core.md")
case "$out" in *systemMessage*linha*) pass=$((pass+1)); echo "ok    stop-audit avisa a violacao";;
                                   *) fail=$((fail+1)); echo "FALHA stop-audit aviso: $out";; esac
grep -q "first sentence" "$SAD/prompt.txt" 2>/dev/null && { pass=$((pass+1)); echo "ok    stop-audit julga contra o nucleo"; } || { fail=$((fail+1)); echo "FALHA stop-audit nao passou o nucleo"; }

# veredito OK nao interrompe ninguem
out=$(sa OK "$REPO/skills/concise/hooks/core.md")
[ -z "$out" ] && { pass=$((pass+1)); echo "ok    stop-audit cala quando esta OK"; } || { fail=$((fail+1)); echo "FALHA stop-audit falou com OK: $out"; }

# nucleo ausente: cai no resumo embutido em vez de morrer
rm -f "$SAD/prompt.txt"
out=$(sa "linha ruim" "$SAD/nao-existe.md")
grep -q "first sentence" "$SAD/prompt.txt" 2>/dev/null && { pass=$((pass+1)); echo "ok    stop-audit tem fallback sem o nucleo"; } || { fail=$((fail+1)); echo "FALHA stop-audit fallback"; }

echo "--- boas-vindas cita todo comando"
# O texto de boas-vindas do notices.sh e um mapa do plugin, e ele envelheceu
# calado quando o :handoff entrou. Todo arquivo em commands/ tem que aparecer
# nele, entao um comando novo quebra este teste em vez de sair do mapa.
for port in concise; do
  hj="$REPO/skills/$port/hooks/hooks.json"
  faltando=""
  for cmd in "$REPO/skills/$port/commands/"*.md; do
    n=$(basename "$cmd" .md)
    grep -q ":$n\b" "$hj" || faltando="$faltando $n"
  done
  [ -z "$faltando" ] && { pass=$((pass+1)); echo "ok    boas-vindas de $port cita os comandos"; } || { fail=$((fail+1)); echo "FALHA boas-vindas de $port nao cita:$faltando"; }
done

echo "--- comando aponta para secao que existe"
# Comando diz "siga a secao X das regras". Quando a secao e renomeada, a
# referencia envelhece calada e o comando manda ler o que nao existe mais —
# aconteceu tres vezes entre 1.32.0 e 1.41.0.
for port in concise; do
  secoes="$FH/secoes-$port.txt"
  sed -n 's/^###* //p' "$REPO/skills/$port/SKILL.md" | tr -d '\r' > "$secoes"
  mortas=""
  for f in "$REPO/skills/$port/commands/"*.md "$REPO/skills/$port/agents/"*.md; do
    while read -r s; do
      [ -n "$s" ] || continue
      grep -qxF "$s" "$secoes" || mortas="$mortas $(basename "$f"):\"$s\""
    done <<EOF
$(perl -CSD -0777 -ne 'while (/"([^"]+)"\s+section|seção\s+"([^"]+)"/g) { my $s=($1//$2); $s =~ s/\s+/ /g; print "$s\n" }' "$f")
EOF
  done
  [ -z "$mortas" ] && { pass=$((pass+1)); echo "ok    referencias de secao em $port existem"; } || { fail=$((fail+1)); echo "FALHA secao morta em $port:$mortas"; }
done

echo "--- frontmatter de comando parseia"
# Valor de frontmatter comecando em `[` e uma sequencia YAML, e um crase
# abrindo item e token reservado: o parser desiste e o comando carrega com
# metadata vazia — sem descricao e sem dica de argumento na lista de comandos,
# calado. Foi assim que /concise:pr e :commit ficaram sem descricao.
for port in concise; do
  cruas=$(grep -l -E '^(description|argument-hint): \[' "$REPO/skills/$port/commands/"*.md 2>/dev/null | while read -r f; do basename "$f"; done | tr '\n' ' ')
  [ -z "$cruas" ] && { pass=$((pass+1)); echo "ok    frontmatter de $port sem sequencia crua"; } || { fail=$((fail+1)); echo "FALHA frontmatter nao citado em $port: $cruas"; }
done

echo "--- route-hint: a PR passa pelo comando que a escreve"
# Uma negativa por sessao, e a segunda chamada passa. Se ela nao passasse, o
# hook viraria parede: a sessao nao teria como abrir PR nenhuma.
R="$REPO/skills/concise/hooks/route-hint.sh"
RT="$FH/rt"; mkdir -p "$RT"
r () { # nome, esperado(deny|allow), stdin
  out=$(printf '%s' "$3" | HOME="$FH" TMPDIR="$RT" bash "$R" "MOTIVO" .concise-no-route-hint)
  got=allow; case "$out" in *permissionDecision*) got=deny;; esac
  if [ "$got" = "$2" ]; then pass=$((pass+1)); printf 'ok    %-46s %s\n' "$1" "$got"
  else fail=$((fail+1)); printf 'FALHA %-46s esperado=%s obtido=%s\n' "$1" "$2" "$got"; fi
}
r "gh pr create avisa na primeira vez"   deny  '{"session_id":"s1","command":"gh pr create --fill"}'
r "a segunda chamada da sessao passa"    allow '{"session_id":"s1","command":"gh pr create --fill"}'
r "outra sessao avisa de novo"           deny  '{"session_id":"s2","command":"gh pr create --title x --body y"}'
r "gh pr edit --body avisa"              deny  '{"session_id":"s3","command":"gh pr edit 77 --body-file b.md --body x"}'
r "gh pr view nao avisa"                 allow '{"session_id":"s4","command":"gh pr view 77 --json body"}'
r "git push nao avisa"                   allow '{"session_id":"s5","command":"git push -u origin minha-branch"}'
touch "$FH/.claude/.concise-no-route-hint"
r "opt-out pelo arquivo de flag"         allow '{"session_id":"s6","command":"gh pr create --fill"}'
rm "$FH/.claude/.concise-no-route-hint"
out=$(printf '%s' '{"session_id":"s7","command":"gh pr create --fill"}' | HOME="$FH" TMPDIR="$RT" CONCISE_NO_ROUTE_HINT=1 bash "$R" "M" .concise-no-route-hint)
[ -z "$out" ] && { pass=$((pass+1)); echo "ok    opt-out pela variavel de ambiente"; } || { fail=$((fail+1)); echo "FALHA opt-out por variavel"; }

echo "--- estilo forcado: output style e lembrete por turno"
# O nucleo chega uma vez, no inicio da sessao, e sessao longa se afasta dele.
# Duas camadas seguram: o output style forcado vai no system prompt de toda
# request, e o lembrete entra do lado de cada mensagem. Se uma delas some, o
# estilo volta a depender da sorte — entao as duas quebram teste aqui.
TR="$REPO/skills/concise/hooks/turn-reminder.sh"
ok () { pass=$((pass+1)); echo "ok    $1"; }
ko () { fail=$((fail+1)); echo "FALHA $1"; }
json_ok () { perl -MJSON::PP -e 'local $/; my $j = decode_json(<STDIN>); exit(($j->{hookSpecificOutput}{hookEventName} eq "UserPromptSubmit" && length $j->{hookSpecificOutput}{additionalContext}) ? 0 : 1)'; }

out=$(printf '%s' '{"prompt":"oi"}' | HOME="$FH" bash "$TR" "Resposta na primeira frase." .concise-no-turn-reminder)
printf '%s' "$out" | json_ok && ok "lembrete sai como additionalContext valido" || ko "lembrete nao e JSON de UserPromptSubmit: $out"
case "$out" in *"Resposta na primeira frase."*) ok "lembrete leva o texto recebido" ;; *) ko "lembrete perdeu o texto" ;; esac

out=$(printf '%s' '{}' | HOME="$FH" bash "$TR" 'aspas " e barra \ no texto' .concise-no-turn-reminder)
printf '%s' "$out" | json_ok && ok "aspas e barra no texto nao quebram o JSON" || ko "texto com aspas quebrou o JSON: $out"

touch "$FH/.claude/.concise-no-turn-reminder"
out=$(printf '%s' '{}' | HOME="$FH" bash "$TR" "X" .concise-no-turn-reminder)
[ -z "$out" ] && ok "lembrete: opt-out pelo arquivo de flag" || ko "lembrete ignorou a flag"
rm "$FH/.claude/.concise-no-turn-reminder"
out=$(printf '%s' '{}' | HOME="$FH" CONCISE_NO_TURN_REMINDER=1 bash "$TR" "X" .concise-no-turn-reminder)
[ -z "$out" ] && ok "lembrete: opt-out pela variavel de ambiente" || ko "lembrete ignorou a variavel"

for port in concise; do
  grep -q '"UserPromptSubmit"' "$REPO/skills/$port/hooks/hooks.json" &&
    grep -q 'hooks/turn-reminder.sh' "$REPO/skills/$port/hooks/hooks.json" &&
    ok "hooks.json de $port registra o lembrete" || ko "hooks.json de $port sem o lembrete"
  style=$(ls "$REPO/skills/$port/output-styles/"*.md)
  awk '/^---$/{n++; next} n==1' "$style" | tr -d '\r' | grep -qx 'force-for-plugin: true' &&
    ok "output style de $port e forcado" || ko "output style de $port nao tem force-for-plugin: true"
  # O output style e o hooks/core.md levam o mesmo nucleo por dois caminhos:
  # divergindo, a sessao segue um e a skill audita pelo outro.
  tr -d '\r' < "$style" | awk 'n<2 && /^---$/{n++; next} n>=2' | sed '/./,$!d' |
    diff -q - <(tr -d '\r' < "$REPO/skills/$port/hooks/core.md") >/dev/null &&
    ok "output style de $port igual ao hooks/core.md" || ko "output style de $port difere do hooks/core.md"
  # O card do marketplace e o que se le antes de instalar, e ja ficou para tras
  # da descricao do proprio plugin sem ninguem notar.
  mkt=$(perl -MJSON::PP -e 'binmode STDOUT, ":utf8"; local $/; my $j = decode_json(<STDIN>); print map { $_->{description} } grep { $_->{name} eq $ARGV[0] } @{$j->{plugins}}' "$port" < "$REPO/.claude-plugin/marketplace.json")
  plg=$(perl -MJSON::PP -e 'binmode STDOUT, ":utf8"; local $/; print decode_json(<STDIN>)->{description}' < "$REPO/skills/$port/.claude-plugin/plugin.json")
  [ -n "$mkt" ] && [ "$mkt" = "$plg" ] && ok "descricao do marketplace igual a do plugin $port" || ko "descricao do marketplace difere da do plugin $port"
  # O texto do lembrete viaja entre aspas simples na linha do hooks.json: um
  # apostrofo nele quebra o bash, e o hook falha calado em todo turno.
  cmd=$(perl -MJSON::PP -e 'binmode STDOUT, ":utf8"; local $/; my $j = decode_json(<STDIN>); print $j->{hooks}{UserPromptSubmit}[0]{hooks}[0]{command}' < "$REPO/skills/$port/hooks/hooks.json")
  out=$(printf '%s' '{}' | HOME="$FH" CLAUDE_PLUGIN_ROOT="$REPO/skills/$port" bash -c "$cmd" 2>/dev/null)
  printf '%s' "$out" | json_ok && ok "lembrete de $port roda pela linha do hooks.json" || ko "lembrete de $port quebra na linha do hooks.json: $out"
done

echo "--- skill: arquivos de referencia e tamanho"
# Cada superficie que sai da conversa mora num arquivo proprio, que a skill e
# os comandos citam. Nome errado deixa o comando sem regra, calado. E o
# SKILL.md chegou a 696 linhas: acima de 500 a recomendacao e dividir, e
# depois da compactacao so os primeiros 5.000 tokens da skill voltam.
for port in concise; do
  dir="$REPO/skills/$port"
  faltando=""
  for ref in $(grep -oh 'refer[a-z]*/[a-z-]*\.md' "$dir/SKILL.md" "$dir/commands/"*.md "$dir/agents/"*.md | sort -u); do
    [ -f "$dir/$ref" ] || faltando="$faltando $ref"
  done
  for f in "$dir"/refer*/*.md; do
    n="$(basename "$(dirname "$f")")/$(basename "$f")"
    grep -q "$n" "$dir/SKILL.md" || faltando="$faltando fora-da-skill:$n"
  done
  [ -z "$faltando" ] && ok "referencias de $port existem e a skill cita todas" || ko "referencias de $port:$faltando"
  linhas=$(wc -l < "$dir/SKILL.md" | tr -d ' ')
  [ "$linhas" -le 500 ] && ok "SKILL.md de $port com $linhas linhas" || ko "SKILL.md de $port passou de 500 linhas: $linhas"
done

echo "--- harness dos evals (claude falso)"
# O run.sh passou a rodar os casos em paralelo. Duas coisas que paralelismo
# quebra calado: a ordem do relatorio e o abort quando o CLI morre.
EV="$FH/ev"; mkdir -p "$EV"
printf '#!/usr/bin/env bash\nif [ "$1" = "--help" ]; then echo "--append-system-prompt-file"; exit 0; fi\necho resposta\necho PASS\n' > "$EV/ok"
printf '#!/usr/bin/env bash\nif [ "$1" = "--help" ]; then echo "--append-system-prompt-file"; exit 0; fi\nexit 0\n' > "$EV/vazio"
chmod +x "$EV/ok" "$EV/vazio"

esperado=$(ls "$REPO/evals/cases/"*.md | while read -r c; do basename "$c" .md; done)
obtido=$(CLAUDE_BIN="$EV/ok" bash "$REPO/evals/run.sh" 2>/dev/null | sed -n 's/^PASS  //p')
[ "$esperado" = "$obtido" ] && { pass=$((pass+1)); echo "ok    evals reportam em ordem de arquivo"; } || { fail=$((fail+1)); echo "FALHA ordem do relatorio dos evals"; }

CLAUDE_BIN="$EV/vazio" bash "$REPO/evals/run.sh" >/dev/null 2>&1
[ "$?" -eq 3 ] && { pass=$((pass+1)); echo "ok    evals abortam com CLI mudo"; } || { fail=$((fail+1)); echo "FALHA evals nao abortaram com CLI mudo"; }

# PLUGIN=1 carrega o plugin so na resposta: um juiz com o plugin daria a nota
# com a regra na mao. E o HOME de rascunho e o que impede os hooks de gravar
# estado no ~/.claude de quem roda.
cat > "$EV/grava" <<EOF
#!/usr/bin/env bash
if [ "\$1" = "--help" ]; then echo "--append-system-prompt-file"; exit 0; fi
case " \$* " in *" --append-system-prompt-file "*) papel=resposta ;; *) papel=juiz ;; esac
case " \$* " in *" --plugin-dir "*) com="com plugin" ;; *) com="sem plugin" ;; esac
case "\$HOME" in "$HOME") casa="HOME real" ;; *) casa="HOME de rascunho" ;; esac
echo "\$papel \$com, \$casa" >> "$EV/chamadas"
echo resposta
echo PASS
EOF
chmod +x "$EV/grava"
PLUGIN=1 CLAUDE_CONFIG_DIR="$FH/cfg" ONLY=01 RESPONSES="$EV/respostas" CLAUDE_BIN="$EV/grava" bash "$REPO/evals/run.sh" >/dev/null 2>&1
[ "$(sort -u "$EV/chamadas" 2>/dev/null | tr '\n' ';')" = "juiz sem plugin, HOME real;resposta com plugin, HOME de rascunho;" ] &&
  ok "PLUGIN=1 carrega o plugin so na resposta, com HOME de rascunho" || ko "PLUGIN=1 vazou o plugin para o juiz ou o HOME real para a resposta"
[ -s "$EV/respostas/01-factual-question.1.txt" ] && ok "RESPONSES guarda cada resposta" || ko "RESPONSES nao guardou a resposta"
env -u CLAUDE_CONFIG_DIR PLUGIN=1 ONLY=01 CLAUDE_BIN="$EV/ok" bash "$REPO/evals/run.sh" >/dev/null 2>&1
[ "$?" -eq 2 ] && ok "PLUGIN=1 recusa rodar sem config isolada" || ko "PLUGIN=1 rodou sem config isolada"

# Rodada barata: ONLY com varios numeros, MIN_RUNS que para quando as tentativas
# concordam com a rodada salva, RESULTS que so reescreve as linhas que rodaram,
# e COMPARE que roda tudo e sai com 1 quando um caso piora.
obtido=$(ONLY=1,03 CLAUDE_BIN="$EV/ok" bash "$REPO/evals/run.sh" 2>/dev/null | sed -n 's/^PASS  //p' | tr '\n' ' ')
[ "$obtido" = "01-factual-question 03-false-premise " ] && ok "ONLY aceita varios numeros" || ko "ONLY com varios numeros: $obtido"
cat > "$EV/conta" <<EOF
#!/usr/bin/env bash
if [ "\$1" = "--help" ]; then echo "--append-system-prompt-file"; exit 0; fi
case " \$* " in *" --append-system-prompt-file "*) echo resposta >> "$EV/contadas" ;; esac
echo resposta
echo "\${VEREDITO:-PASS}"
EOF
chmod +x "$EV/conta"
printf '01-factual-question\t5\t5\r\nzz-outro\t1\t5\r\n' > "$EV/salvo.tsv"
: > "$EV/contadas"
RUNS=5 MIN_RUNS=2 ONLY=01 COMPARE="$EV/salvo.tsv" RESULTS="$EV/salvo.tsv" CLAUDE_BIN="$EV/conta" bash "$REPO/evals/run.sh" >/dev/null 2>&1
[ "$(grep -c . "$EV/contadas")" = 2 ] && ok "MIN_RUNS para em 2 quando concorda com a rodada salva" || ko "MIN_RUNS nao parou: $(grep -c . "$EV/contadas") respostas"
[ "$(tr '\t\n' ' ;' < "$EV/salvo.tsv")" = "01-factual-question 2 2;zz-outro 1 5;" ] && ok "RESULTS reescreve so as linhas que rodaram" || ko "RESULTS: $(tr '\t\n' ' ;' < "$EV/salvo.tsv")"
printf '01-factual-question\t5\t5\n' > "$EV/salvo.tsv"
: > "$EV/contadas"
saida=$(RUNS=5 ONLY=01 COMPARE="$EV/salvo.tsv" VEREDITO=FAIL CLAUDE_BIN="$EV/conta" bash "$REPO/evals/run.sh" 2>/dev/null); rc=$?
[ "$rc" -eq 1 ] && printf '%s\n' "$saida" | grep -q "^worse   01-factual-question  5/5 -> 0/2" && [ "$(grep -c . "$EV/contadas")" = 2 ] &&
  ok "COMPARE para quando o que falta nao muda o veredito, e sai com 1" || ko "COMPARE com piora: rc=$rc, $(grep -c . "$EV/contadas") respostas"
printf '01-factual-question\t0\t5\n03-false-premise\t5\t5\n' > "$EV/salvo.tsv"
: > "$EV/contadas"
saida=$(RUNS=5 MIN_RUNS=2 ONLY=01,03 WORSE_ONLY=1 COMPARE="$EV/salvo.tsv" CLAUDE_BIN="$EV/conta" bash "$REPO/evals/run.sh" 2>/dev/null); rc=$?
[ "$rc" -eq 0 ] && printf '%s\n' "$saida" | grep -q "^0 worse, 1 not worse, 1 skipped as unable to get worse" && [ "$(grep -c . "$EV/contadas")" = 2 ] &&
  ok "WORSE_ONLY pula o caso que nao tem como piorar" || ko "WORSE_ONLY: rc=$rc, $(grep -c . "$EV/contadas") respostas"
WORSE_ONLY=1 ONLY=01 CLAUDE_BIN="$EV/ok" bash "$REPO/evals/run.sh" >/dev/null 2>&1
[ "$?" -eq 2 ] && ok "WORSE_ONLY recusa rodar sem COMPARE" || ko "WORSE_ONLY rodou sem COMPARE"

# Um conjunto em evals/sets/ vira ONLY; um numero sem caso sumiria calado.
esperado=$(sed 's/#.*//' "$REPO/evals/sets/core.txt" | tr -d '\r' | grep -o '[0-9][0-9]' | sort | tr '\n' ' ')
obtido=$(SET=core CLAUDE_BIN="$EV/ok" bash "$REPO/evals/run.sh" 2>/dev/null | sed -n 's/^PASS  \([0-9][0-9]\)-.*/\1/p' | tr '\n' ' ')
[ -n "$esperado" ] && [ "$esperado" = "$obtido" ] && ok "SET=core roda exatamente os casos da lista" || ko "SET=core: esperado [$esperado], obtido [$obtido]"
faltando=""
for n in $(sed 's/#.*//' "$REPO"/evals/sets/*.txt | tr -d '\r' | grep -o '[0-9][0-9]'); do
  ls "$REPO"/evals/cases/"$n"-*.md >/dev/null 2>&1 || faltando="$faltando $n"
done
[ -z "$faltando" ] && ok "todo numero em evals/sets/ tem caso" || ko "numeros sem caso em evals/sets/:$faltando"

echo "===== $pass ok, $fail falhas"
[ "$fail" -eq 0 ]
