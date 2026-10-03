# Phase 1 — Recon & Attack-Surface Mapping

**Goal:** Build a complete mental + written model of the codebase before hunting bugs.
Output of this phase feeds every later phase. Do not look for vulnerabilities yet —
map the terrain.

## 1.1 Repository fingerprint

Run and record (adapt commands to the environment):

```bash
# Language + size breakdown
tokei . 2>/dev/null || cloc . 2>/dev/null || (git ls-files | sed 's/.*\.//' | sort | uniq -c | sort -rn)

# Build + dependency manifests
find . -maxdepth 3 \( -name "package.json" -o -name "requirements*.txt" -o -name "pom.xml" \
  -o -name "build.gradle*" -o -name "go.mod" -o -name "Cargo.toml" -o -name "composer.json" \
  -o -name "*.csproj" -o -name "Gemfile" -o -name "pyproject.toml" \) -print

# Framework + runtime signals
grep -rilE "express|fastify|django|flask|fastapi|spring|gin|laravel|rails|nextjs|nestjs" \
  --include=*.{js,ts,py,java,go,php,rb} . | head -50

# Entry points
grep -rnE "app\.(get|post|put|delete|patch)|@(Get|Post|Put|Delete|RequestMapping|RestController)|router\.|@app\.route|http\.HandleFunc" . | head -200
```

## 1.2 Produce an Attack-Surface Inventory table

| # | Entry point | Type | Auth required? | Trust boundary crossed | Handles sensitive data? | File:line |
|---|-------------|------|----------------|------------------------|-------------------------|-----------|

Types to capture: HTTP routes, GraphQL resolvers, gRPC methods, WebSocket handlers,
CLI args, cron/scheduled jobs, message-queue consumers, webhooks, file uploads,
deserialization sinks, template renderers, SSR hydration paths, admin panels.

## 1.3 Data-flow & trust-boundary sketch

For each major flow, note: **source → transformation → sink**. Flag any path where
untrusted input reaches a dangerous sink (SQL, OS command, filesystem, HTTP client,
template engine, reflection, native code) without validation/encoding in between.

## 1.4 Secrets & config sweep (inventory only, exploit later)

```bash
grep -rnE "(api[_-]?key|secret|passwd|password|token|private[_-]?key|BEGIN RSA|aws_access)" \
  --include=*.{env,yml,yaml,json,properties,js,ts,py,go,java,php} . | head -100
git log --all --oneline -S "password" 2>/dev/null | head
```

## 1.5 Phase-1 deliverable

Write a concise **Codebase Overview**: purpose, architecture, tech stack, deployment
model (if inferable), and the top 10 riskiest areas you will prioritize in P3.
Carry the Attack-Surface Inventory forward verbatim.
