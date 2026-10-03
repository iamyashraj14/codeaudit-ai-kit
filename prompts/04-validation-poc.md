# Phase 4 — Validation, Reliability Re-testing & PoC

**Goal:** Convert candidates into evidence a triager can verify in minutes.

## 4.1 Reproduce, don't assert

For each candidate, build the **minimal** reproduction:
- Prefer a runnable PoC: a `curl` request, a short script, or a failing unit test.
- If dynamic execution is possible in-sandbox, run it and paste **real** output.
- If it is not, say so explicitly and give exact manual steps + expected output.

## 4.2 Reliability matrix (≥ 5 runs for dynamic findings)

| Finding | Run 1 | Run 2 | Run 3 | Run 4 | Run 5 | Determinism |
|---------|-------|-------|-------|-------|-------|-------------|

Record what you observed each run (status code, response fragment, state change).
"Determinism" = `Deterministic | Intermittent (n/5) | Environment-dependent`.

## 4.3 Evidence package per finding

- Exact request/command(s), each annotated with what it does and why.
- Observed response/output (redact real secrets; show structure).
- Before/after state change proving impact (row read, file written, privilege gained).
- Negative control: show the same request fails for an unauthorized/baseline user,
  proving the issue is the vulnerability and not expected behavior.

## 4.4 Safety guardrails

- Never run destructive PoCs against shared state without a disposable fixture.
- Never target anything outside the sandbox/repo.
- For DoS/resource-exhaustion findings, demonstrate the *mechanism* at tiny scale and
  reason about scale-up — do not actually exhaust the host.

## 4.5 Phase-4 deliverable

Each surviving finding now has: minimal PoC, real-or-clearly-labelled evidence, a
reliability matrix, and a negative control. Demote anything that failed to reproduce.
