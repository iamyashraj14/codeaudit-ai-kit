# CodeAudit AI Kit

An advanced, prompt-driven toolkit that turns an AI coding agent (Claude Code, Cursor,
Aider, Copilot CLI, etc.) into a structured **source-code security auditor** — producing
triage-ready findings with real evidence, standards-aligned classification, and
quantified business impact.

Inspired by the single-file "source code analyze prompt" pattern, rebuilt as a modular,
multi-phase engagement framework with language profiles, a scoring model, a JSON finding
ledger, and a report template.

> **Intended use — defensive only.** For auditing code **you own or are authorized to
> assess**: VAPT engagements, internal reviews, bug-bounty on in-scope programs, PR
> security gates. Always operate within an explicit scope / rules-of-engagement.

---

## What's different from the original

| Original | This kit |
|----------|----------|
| One big prompt | 7 modular phases you can run end-to-end or à la carte |
| Business-impact section | Same, plus **CVSS 4.0 + business overlay** scoring model |
| Generic hunt | **Language profiles** (web/JS, Python, Java) with concrete grep sinks |
| CWE mapping | CWE **+ OWASP Top 10 + ASVS 5.0 + MITRE ATT&CK** |
| Markdown report | Markdown report **+ JSON finding ledger** (schema-validated) **+ SBOM notes** |
| Manual assembly | `assemble-prompt.sh` builds one ready-to-paste prompt per profile |
| — | Triage-readiness **checklist**, severity config, quick-scan **lite** prompt |
| — | India-context compliance lenses (CERT-In 6h reporting) alongside GDPR/PCI/HIPAA |

---

## Layout

```
codeaudit-ai-kit/
├── README.md
├── prompts/
│   ├── 00-master-orchestrator.md      # engagement contract + mindset + phases
│   ├── 01-recon-surface-map.md        # P1: attack-surface mapping
│   ├── 02-threat-model.md             # P2: STRIDE + business-asset map + abuse cases
│   ├── 03-vuln-hunt-generic.md        # P3: core, language-agnostic hunt
│   ├── 03-vuln-hunt-web.md            # P3 profile: JS/TS/Node/front-end
│   ├── 03-vuln-hunt-python.md         # P3 profile: Django/Flask/FastAPI
│   ├── 03-vuln-hunt-java.md           # P3 profile: Spring/Jakarta
│   ├── 04-validation-poc.md           # P4: reproduce, re-test x5, PoC
│   ├── 05-classify-score.md           # P5: CWE/OWASP/CVSS + business impact + scope
│   ├── 06-duplicate-research.md       # P6: prior-art / duplicate research
│   └── quick-scan-lite.md             # single-shot fast pass
├── templates/
│   └── report-template.md             # final report structure
├── checklists/
│   └── triage-checklist.md            # pre-delivery quality gate
├── config/
│   ├── severity-model.yaml            # CVSS 4.0 + business-damage bands
│   └── finding-schema.json            # JSON schema for the finding ledger
└── scripts/
    └── assemble-prompt.sh             # concatenate kit -> one pasteable prompt
```

---

## Quick start

1. **Pick a profile** matching the target: `generic`, `web`, `python`, or `java`.
2. **Assemble the prompt:**
   ```bash
   ./scripts/assemble-prompt.sh MyTargetRepo web
   # -> writes assembled-MyTargetRepo.md
   ```
3. **Paste your scope** into the `rules_of_engagement` block in Phase 0 of the assembled
   file. The agent will refuse to produce findings without it.
4. **Feed it to your agent** running *inside the target repository*. For example with
   Claude Code: open the repo, paste the assembled prompt, let it run the phases.
5. **Collect deliverables** in `../reports/`:
   - `<PROGRAM_NAME>.md` — full report, findings sorted by business impact
   - `<PROGRAM_NAME>-findings.json` — machine-readable ledger
   - `<PROGRAM_NAME>-sbom-notes.md` — dependency/SCA notes
6. **Gate on the checklist** (`checklists/triage-checklist.md`) before delivering.

For a fast look, skip assembly and use `prompts/quick-scan-lite.md` directly.

---

## Design principles

- **Business impact first** — every finding answers "what does this cost the business?"
- **Evidence over assertion** — nothing is "confirmed" without observed output; no invented
  CVEs/logs/reports.
- **Depth over count** — prove or disprove each candidate; chain weak issues instead of
  padding the report.
- **Comparable & defensible** — standard taxonomy + reproducible scoring + quoted scope.
- **Triager-friendly** — a reviewer can verify any finding in minutes.

---

## Extending

- Add a profile: copy `03-vuln-hunt-web.md` to `03-vuln-hunt-<stack>.md`, swap the grep
  sinks and framework checks, and `assemble-prompt.sh <name> <stack>` picks it up.
- Tune scoring: edit `config/severity-model.yaml`.
- Add compliance lenses: extend `compliance_lenses` in the Phase-0 block and the
  Business-Impact Analysis in `05-classify-score.md`.

## License & responsibility
Use only against systems you are authorized to test. You are responsible for staying
within scope and applicable law.