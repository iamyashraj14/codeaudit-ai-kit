# Phase 5 — Classification, Scoring & Scope Check

**Goal:** Make every finding comparable, defensible, and provably in-scope.

## 5.1 Weakness classification (mandatory)

For each finding:
- **Primary CWE** — ID, name, and *why this mapping fits this root cause specifically*.
- **Secondary CWE(s)** — listed briefly if more than one applies.
- **OWASP Top 10 (2021)** category and **OWASP ASVS 5.0** control reference.
- **MITRE ATT&CK** technique(s) the exploit would enable, where relevant.

Do not guess CWEs. If unsure between two, state the ambiguity and justify the primary.

## 5.2 Severity — CVSS 4.0 + business overlay

1. Produce a **CVSS 4.0 vector** and base score. Show the vector string.
2. Apply the **business-impact overlay** (see `config/severity-model.yaml`): a finding's
   final severity is the *higher* of its CVSS band and its business-damage band.
3. Record the final **Severity**: `Critical | High | Medium | Low | Informational`.

### Business-damage bands (summarized)
- **Catastrophic / Critical:** existential — full DB exfil, mass ATO, RCE on core service,
  payment theft at scale, regulator-reportable breach of crown-jewel data.
- **Large / High:** $1M+ exposure, cross-tenant breach, admin/billing escalation.
- **Medium:** $10K–$1M exposure, scoped data exposure, meaningful logic abuse.
- **Low / Informational:** <$10K, hardening gaps, defense-in-depth.

## 5.3 Mandatory Business-Impact Analysis (every finding)

Complete each subsection or mark `N/A` with a one-line reason:
- **Financial** — direct theft, fraud, free paid-feature access, regulatory fines
  (GDPR up to 4% global revenue; PCI-DSS $5K–$100K/mo; HIPAA up to $1.9M/yr/category).
- **Data breach & privacy** — data categories, record/user count, notification duties
  (GDPR 72h, CERT-In 6h for Indian entities, state laws, HIPAA).
- **Reputational & trust** — newsworthiness, churn risk, enterprise-customer compliance
  knock-on, partner/investor impact.
- **Operational & availability** — downtime, data loss/corruption, ransomware leverage.
- **Competitive & IP** — trade-secret/algorithm exposure.
- **Compliance & legal** — specific regulation/clause breached, civil/class-action risk,
  SLA breach.
- **Attacker Motivation Score** — which personas and why.

## 5.4 Scope check (mandatory)

For each finding, label `In-Scope | Borderline | Out-of-Scope` and **quote the exact
clause** from the pasted rules of engagement that applies. Group findings accordingly in
the report; out-of-scope items appear only in the informational section.

## 5.5 Phase-5 deliverable

A fully scored, classified, scope-checked finding set, sorted by final business-impact
severity, ready for duplicate research and reporting.
