# Phase 2 — Threat Modelling & Business-Asset Mapping

**Goal:** Turn the terrain map from P1 into a prioritized threat picture so that P3
spends effort where real damage lives.

## 2.1 Business-Asset Risk Map (mandatory table)

| Component / Module | Business value | Data sensitivity | Tenancy model | Attack risk rating |
|--------------------|----------------|------------------|---------------|--------------------|

- **Business value:** revenue-critical / operational / support / cosmetic.
- **Data sensitivity:** PII, PCI, PHI, credentials, IP, public.
- **Tenancy model:** single-tenant / multi-tenant-shared-db / multi-tenant-isolated.
- **Attack risk rating:** Critical / High / Medium / Low (your judgement, justify briefly).

## 2.2 STRIDE pass per trust boundary

For each trust boundary identified in P1, enumerate applicable threats:

| Boundary | S | T | R | I | D | E | Notes |
|----------|---|---|---|---|---|---|-------|

(Spoofing, Tampering, Repudiation, Info-disclosure, DoS, Elevation.)

## 2.3 Abuse-case catalogue (business-logic focus)

List concrete abuse cases a real attacker would attempt. Prioritize the subtle,
high-payoff logic flaws that SAST tools miss:

- Price / quantity / currency manipulation at checkout
- Cross-tenant data access (B2B SaaS breach scenario)
- Free-tier / quota / entitlement bypass
- Privilege escalation to admin, billing, or support roles
- Account-takeover chains (reset tokens, session fixation, OAuth state)
- Referral / coupon / promo abuse, negative-value transactions
- Rate-limit bypass on OTP, login, payment, export
- Mass data exfiltration via enumeration or bulk export endpoints
- Race conditions on balance, inventory, or idempotency keys
- Webhook/callback spoofing and replay

## 2.4 Attacker personas & motivation

Map which personas would target this system and why: nation-state/APT, organized
crime, competitors, opportunists, insiders, hacktivists. This feeds the
**Attacker Motivation Score** in each finding.

## 2.5 Phase-2 deliverable

A ranked **Hunt Plan**: the ordered list of components/flows P3 will attack, each with
the specific abuse cases and vulnerability classes to test. Riskiest first.
