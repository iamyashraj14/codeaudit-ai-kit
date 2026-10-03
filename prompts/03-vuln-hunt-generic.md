# Phase 3 — Deep Vulnerability Hunt (Generic / Language-Agnostic)

Use this core hunt prompt for any stack, then layer a language profile
(`03-vuln-hunt-web.md`, `-java.md`, `-python.md`, etc.) on top.

> **Rule:** depth over breadth. When you find a candidate, *stop and prove it* before
> moving on. Do not pad the report with weak findings.

## 3.1 Priority vulnerability classes (hunt in this order)

1. **Authentication & session** — broken auth, weak token generation, JWT `alg=none`/key
   confusion, missing expiry, session fixation, predictable identifiers.
2. **Authorization** — IDOR / BOLA, broken function-level authz, missing tenant checks,
   mass-assignment, horizontal & vertical privilege escalation.
3. **Injection** — SQL / NoSQL / ORM, OS command, LDAP, XPath, template (SSTI),
   expression-language, header/CRLF, log injection.
4. **SSRF & request forgery** — unvalidated outbound fetch, cloud-metadata reach,
   webhook targets, PDF/image/URL preview generators.
5. **Deserialization & object injection** — native deserialization, pickle, YAML,
   unsafe `eval`, prototype pollution.
6. **File handling** — path traversal, arbitrary upload, zip-slip, XXE, unsafe extraction.
7. **Secrets & crypto** — hardcoded secrets, weak hashing (MD5/SHA1 for passwords),
   ECB mode, static IV/nonce, missing signature verification, weak randomness.
8. **Business logic & race conditions** — from the P2 abuse-case catalogue.
9. **Supply chain** — vulnerable/abandoned deps, typosquats, postinstall scripts,
   unpinned versions, integrity-check gaps.
10. **Info disclosure & misconfig that is *actively exploitable*** — verbose errors with
    stack traces reaching users, debug endpoints, directory listing, CORS `*` with creds.

## 3.2 Per-candidate workbook (fill for each)

```
Candidate: <short name>
Location:  <file>:<line-range>  function/class <name>
Source:    <where untrusted input enters>
Sink:      <dangerous operation reached>
Path:      <source → ... → sink, name every hop>
Snippet:   <minimal code excerpt proving the flow>
Guard?:    <validation/encoding present? why insufficient?>
Pre-reqs:  <auth level, config, feature flag needed>
Confidence:<Confirmed | High | Medium | Speculative>
```

## 3.3 Taint discipline

Trace every candidate end-to-end. A finding without a demonstrated source→sink path is
**not** a confirmed finding — demote it to Speculative and move on, or disprove it.

## 3.4 Chaining mandate

Low-severity issues that cannot be exploited alone must be **chained**. Explicitly
construct the highest-impact end-to-end path multiple weaknesses enable (e.g.
`verbose error → username enum → weak reset token → ATO → tenant data export`).
A chain is a single finding scored at the chain's impact, with each link documented.

## 3.5 Phase-3 deliverable

A list of validated candidates with completed workbooks, ready for P4 validation.
Nothing reaches the report until it passes P4 and P5.
