# Triage Readiness Checklist
Run this before declaring the audit complete. Every box must be checked or explicitly waived.

## Coverage
- [ ] Every entry point in the attack-surface inventory was reviewed
- [ ] Every trust boundary got a STRIDE pass
- [ ] All P2 abuse cases were tested or marked not-applicable with reason
- [ ] Dependency / SCA sweep completed and reachable vulns triaged

## Per-finding quality gate
- [ ] Exact location (file:line, symbol) given
- [ ] Source → sink path named at every hop
- [ ] Minimal PoC present (runnable, or manual steps + expected output)
- [ ] Real output pasted (or limitation explicitly stated — nothing fabricated)
- [ ] Negative control shown (baseline user cannot reproduce)
- [ ] Reliability matrix (>=5 runs) for dynamic findings
- [ ] Primary CWE + justification; OWASP/ASVS mapping
- [ ] CVSS 4.0 vector + business-impact overlay -> final severity
- [ ] Full Business-Impact Analysis (no skipped sections)
- [ ] Confidence label assigned
- [ ] Scope label + quoted clause
- [ ] Related-reports block + novelty assessment
- [ ] Immediate + long-term fix with corrected code

## Report hygiene
- [ ] Findings sorted highest business impact -> lowest
- [ ] Speculative items only in Triage-Judgement section
- [ ] Out-of-scope items only in Informational section
- [ ] No invented CVEs, logs, or prior reports
- [ ] Executive summary readable by a non-technical board member

## Deliverables written
- [ ] ../reports/<PROGRAM_NAME>.md
- [ ] ../reports/<PROGRAM_NAME>-findings.json (validates against finding-schema.json)
- [ ] ../reports/<PROGRAM_NAME>-sbom-notes.md
- [ ] All output paths printed in final response
