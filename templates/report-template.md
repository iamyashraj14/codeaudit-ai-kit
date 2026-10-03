# Security Audit Report — `<PROGRAM_NAME>`

| | |
|---|---|
| **Engagement** | `<PROGRAM_NAME>` |
| **Classification** | `<INTERNAL / CLIENT CONFIDENTIAL / PUBLIC>` |
| **Audit type** | Source-code security review (SAST + manual + logic) |
| **Scope mode** | `<FULL_REPO / DIFF / ALLOWLIST>` |
| **Commit / ref** | `<git sha>` |
| **Date** | `<YYYY-MM-DD>` |
| **Auditor** | `<name / org>` |
| **Severity model** | CVSS 4.0 + business-impact overlay |

---

## 1. Executive Summary
*Audience: CEO / CTO / board. No jargon.*

- **Worst thing an attacker can do right now:** `<one plain sentence>`
- **Total estimated financial exposure:** `<range across all findings>`
- **Most critical compliance risks:** `<GDPR / PCI / HIPAA / CERT-In / ...>`
- **Overall security posture (2–3 sentences):** `<...>`
- **Remediation urgency:** `<prioritized statement>`

### Findings at a glance

| # | Title | Severity | CVSS 4.0 | Confidence | Scope | Business damage (1-liner) |
|---|-------|----------|----------|------------|-------|---------------------------|

---

## 2. Methodology
Phases executed (recon → threat model → hunt → validation → scoring → duplicate research),
tools used, coverage achieved, and explicit limitations.

---

## 3. Attack Surface Overview

### 3.1 Codebase overview
`<purpose, architecture, stack, deployment model>`

### 3.2 Business-Asset Risk Map
| Component | Business value | Data sensitivity | Tenancy | Attack risk |
|-----------|----------------|------------------|---------|-------------|

### 3.3 Attack-surface inventory
| # | Entry point | Type | Auth? | Trust boundary | Sensitive data? | File:line |
|---|-------------|------|-------|----------------|-----------------|-----------|

---

## 4. Findings by Severity (Highest Business Impact → Lowest)

> Repeat the block below for each finding.

### F-01 · `<Title>`

**Severity:** `<Critical/High/...>`  ·  **CVSS 4.0:** `<score>` `<vector>`  ·  **Confidence:** `<Confirmed/High/...>`

**Boardroom version:** `<one sentence of business damage>`

**Weakness classification**
- Primary CWE: `CWE-xxx — <name>` — *why it fits:* `<...>`
- Secondary CWE(s): `<...>`
- OWASP Top 10 / ASVS: `<A0x:2021 / Vx.x.x>`  ·  MITRE ATT&CK: `<Txxxx>`

**Affected version(s):** `<...>`  ·  **Last known unaffected:** `<... / undetermined>`
**Affected component(s) / files:** `<file:line, function/class>`

**Component overview:** `<what this code does>`

**Vulnerability details:** `<root cause, attack path, preconditions, why exploitable>`

**Business Impact Analysis**
- Financial: `<...>`
- Data breach & privacy: `<...>`
- Reputational & trust: `<...>`
- Operational & availability: `<...>`
- Competitive & IP: `<...>`
- Compliance & legal: `<...>`
- Attacker Motivation Score: `<personas + rationale>`

**Proof / evidence:** `<annotated requests, real output, state change, negative control>`

**Step-by-step reproduction:**
1. `<command — what it does>`
2. `<...>`

**Reliability verification (≥5 runs):**
| Run | 1 | 2 | 3 | 4 | 5 | Determinism |
|-----|---|---|---|---|---|-------------|

**Fix recommendations**
- *Immediate (stop the bleeding):* `<...>`
- *Long-term (architectural):* `<...>`
- *Remediation effort:* `<low/medium/high>`
- *Corrected code example:*
```diff
- <vulnerable>
+ <fixed>
```

**Scope mapping:** `<In-scope — quote clause>`

**Related reports & similar issues:** `<closest matches, novelty, triager search kit>`

---

## 5. Findings Requiring Triage Judgement
*Borderline / lower-confidence items, each with the open question for the triager.*

## 6. Out-of-Scope / Informational Observations
*Hardening and defense-in-depth notes; explicitly not reportable under current scope.*

## 7. Overall Remediation Roadmap
| Window | Action | Finding(s) | Business risk reduced |
|--------|--------|------------|-----------------------|
| 24–48h | | | |
| ≤ 2 weeks | | | |
| ≤ 90 days | | | |
| Architectural | | | |

## 8. Appendix / Raw Notes
*Tool output, extended traces, SBOM references.*
