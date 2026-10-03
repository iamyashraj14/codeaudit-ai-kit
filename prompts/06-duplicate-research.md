# Phase 6 — Duplicate / Prior-Art Research

**Goal:** Prevent duplicate reports and establish novelty with evidence. Allocate real
effort here — a duplicate finding wastes everyone's time and costs credibility.

## 6.1 Repo-internal prior art (always do this)

```bash
# Security-relevant history
git log --all --oneline --regexp-ignore-case -E --grep="security|CVE|vuln|XSS|injection|auth|bypass|fix" | head -50
git log --all -S "<identifier-from-finding>" --oneline | head
# Advisories, docs, notes
find . -iname "SECURITY.md" -o -iname "CHANGELOG*" -o -iname "*advisory*" | head
grep -rniE "TODO|FIXME|HACK|XXX|insecure|do not ship" --include=*.{js,ts,py,java,go,php,rb} . | head -50
```
Review: issues/PRs (if present), release notes, test files that may already cover the bug,
and revert/hotfix commits touching the same code.

## 6.2 External prior art (if network access is available)

Search multiple angles for each finding:
- **Technical identifiers:** function/class names, route paths, header/param names, exact
  error strings, feature names.
- **Vulnerability pattern:** "IDOR", "SSRF", "deserialization", "tenant bypass", etc.,
  combined with the framework/library name.
- **Sources:** CVE/NVD, GitHub Security Advisories (GHSA), vendor advisories, public
  write-ups/blogs, bounty disclosure posts (HackerOne/Bugcrowd hacktivity), Exploit-DB.

If network access is unavailable, **state that explicitly** and do the deepest possible
repo-based research instead.

## 6.3 "Related Reports & Similar Issues" block (per finding)

```
Closest matches (most → least similar):
  - <source/link/ref> — overlap: <what matches> | difference: <what's distinct>
Novelty assessment: <Novel | Variant of known | Likely duplicate>
Triager search kit: <exact keywords/identifiers to confirm duplication in 2 minutes>
```

## 6.4 Integrity rules

- Never invent CVEs, GHSAs, or past reports. Cite only real sources with links/refs.
- If you cannot verify a match, say "unverified — triager should confirm" rather than
  asserting a duplicate.

## 6.5 Phase-6 deliverable

Each finding carries a Related-Reports block and a novelty assessment, ready for the
report.
