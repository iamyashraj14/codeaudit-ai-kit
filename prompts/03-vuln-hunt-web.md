# Phase 3 Profile — Web / JavaScript / TypeScript / Node

Layer this on top of `03-vuln-hunt-generic.md` for JS/TS/Node/front-end stacks.

## Sinks & patterns to grep

```bash
# XSS sinks
grep -rnE "innerHTML|outerHTML|dangerouslySetInnerHTML|document\.write|\.html\(|v-html|insertAdjacentHTML" --include=*.{js,jsx,ts,tsx,vue,svelte} .

# Injection / eval
grep -rnE "\beval\(|new Function\(|child_process|exec\(|execSync|spawn\(|vm\.runIn" --include=*.{js,ts} .

# SQL / NoSQL
grep -rnE "query\(|\.raw\(|sequelize\.query|knex\.raw|\$where|mapReduce|\.find\(\s*\{.*req\." --include=*.{js,ts} .

# SSRF
grep -rnE "axios\.|fetch\(|http\.request|got\(|request\(|needle\(" --include=*.{js,ts} . | grep -iE "req\.|params|query|body"

# Prototype pollution
grep -rnE "Object\.assign|_\.merge|_\.extend|deepmerge|JSON\.parse\(.*req|__proto__|constructor\[" --include=*.{js,ts} .

# Auth / JWT
grep -rnE "jsonwebtoken|jwt\.(sign|verify)|algorithm|none|secret\s*[:=]|cookie.*httpOnly" --include=*.{js,ts} .
```

## Framework-specific checks

- **Express/Fastify/Nest:** middleware ordering, missing `helmet`, body-parser limits,
  trust-proxy misconfig, route-level vs global auth guards, `req.params` in file paths.
- **Next.js:** `getServerSideProps` trust, API-route authz, `next/image` SSRF via remote
  loader, exposed `.env` in client bundles (`NEXT_PUBLIC_` leakage of secrets).
- **GraphQL:** missing depth/complexity limits, introspection in prod, field-level authz,
  batching abuse, IDOR via node interface.
- **ORM (Prisma/TypeORM/Sequelize/Mongoose):** raw-query escape hatches, mass-assignment
  via spread of `req.body`, `select *` leaking sensitive columns.

## Front-end specific

- DOM XSS via `location`, `postMessage` without origin check, `window.name`.
- Client-side auth/entitlement checks with no server enforcement (always a logic flaw).
- Secrets or feature flags shipped in the JS bundle.
- Insecure `postMessage` targets (`"*"`), open redirect via unvalidated `returnUrl`.

## Supply chain (Node)

```bash
npm audit --json 2>/dev/null | head -c 4000
# lockfile integrity, postinstall scripts, suspicious deps
grep -rn "postinstall\|preinstall" package.json
```
Report only deps that are actually reachable and exploitable in context.
