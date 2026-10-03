# Phase 3 Profile — Python (Django / Flask / FastAPI)

Layer on top of `03-vuln-hunt-generic.md`.

## Sinks & patterns

```bash
# Code exec / injection
grep -rnE "\beval\(|\bexec\(|pickle\.loads|yaml\.load\b|__import__|subprocess|os\.system|os\.popen|marshal\.loads" --include=*.py .

# SQL
grep -rnE "\.raw\(|cursor\.execute\(.*%|\.extra\(|f\"SELECT|f'SELECT|\.format\(.*SELECT|text\(" --include=*.py .

# SSRF / requests
grep -rnE "requests\.(get|post)|urllib|httpx|aiohttp" --include=*.py . | grep -iE "request\.|params|\.args|\.json|\.form"

# Template injection
grep -rnE "render_template_string|Template\(|from_string|Jinja2" --include=*.py .

# Deserialization / unsafe parse
grep -rnE "pickle|cPickle|yaml\.load\(|jsonpickle|dill\.|shelve" --include=*.py .

# Crypto / secrets
grep -rnE "md5|sha1|DES|ECB|random\.random|random\.randint|SECRET_KEY\s*=|verify=False" --include=*.py .
```

## Framework-specific

- **Django:** `DEBUG=True` in prod, `ALLOWED_HOSTS=['*']`, `mark_safe`/`|safe` XSS,
  `.extra()`/`.raw()` SQLi, missing `@login_required`/permission mixins, mass-assignment
  via `ModelForm` `fields='__all__'`, pickled sessions, `SECRET_KEY` reuse, open redirect
  in `next` param, CSRF exemptions.
- **Flask:** `render_template_string` SSTI, `debug=True`, `app.secret_key` hardcoded,
  `send_file`/`send_from_directory` path traversal, missing `SameSite`/`Secure` cookies.
- **FastAPI:** dependency-injection auth gaps, Pydantic model leakage of secret fields,
  unvalidated path params in filesystem/DB access, background-task injection.

## Supply chain

```bash
pip-audit 2>/dev/null | head -c 3000 || safety check 2>/dev/null | head -c 3000
```
