#!/usr/bin/env bash
# assemble-prompt.sh — concatenate the kit into one prompt for an AI CLI agent.
#
# Usage:
#   ./assemble-prompt.sh <PROGRAM_NAME> [profile]
#   profile = generic (default) | web | python | java
#
# Then paste the program's scope/guidelines where indicated, and feed the result
# to your AI coding agent running inside the target repository.

set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROGRAM="${1:-TARGET}"
PROFILE="${2:-generic}"
OUT="${ROOT}/assembled-${PROGRAM}.md"

PROFILE_FILE="${ROOT}/prompts/03-vuln-hunt-${PROFILE}.md"
[ -f "$PROFILE_FILE" ] || { echo "Unknown profile: $PROFILE" >&2; exit 1; }

{
  echo "<!-- Assembled AI Source-Code Audit Prompt for: ${PROGRAM} (profile: ${PROFILE}) -->"
  echo
  for f in \
    "prompts/00-master-orchestrator.md" \
    "prompts/01-recon-surface-map.md" \
    "prompts/02-threat-model.md" \
    "prompts/03-vuln-hunt-generic.md" \
    "prompts/03-vuln-hunt-${PROFILE}.md" \
    "prompts/04-validation-poc.md" \
    "prompts/05-classify-score.md" \
    "prompts/06-duplicate-research.md"
  do
    # skip duplicate generic when profile is generic
    if [ "$PROFILE" = "generic" ] && [ "$f" = "prompts/03-vuln-hunt-generic.md" ]; then
      case "$printed_generic" in yes) continue;; esac
      printed_generic=yes
    fi
    echo "

---

"
    cat "${ROOT}/${f}"
  done
  echo "

---

## Report format to follow

See templates/report-template.md (reproduced below).

"
  cat "${ROOT}/templates/report-template.md"
  echo "

---

Replace <PROGRAM_NAME> with: ${PROGRAM}
Before starting, paste the program scope into the rules_of_engagement block in Phase 0."
} > "$OUT"

echo "Wrote: $OUT"
wc -l "$OUT"
