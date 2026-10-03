# Phase 3 Profile — Java / Kotlin (Spring / Jakarta EE)

Layer on top of `03-vuln-hunt-generic.md`.

## Sinks & patterns

```bash
# Injection
grep -rnE "Statement|createQuery\(.*\+|createNativeQuery|entityManager\.createQuery\(.*\+" --include=*.{java,kt} .
grep -rnE "Runtime\.getRuntime\(\)\.exec|ProcessBuilder" --include=*.{java,kt} .

# Deserialization
grep -rnE "ObjectInputStream|readObject|XMLDecoder|XStream|readValue\(.*enableDefaultTyping|Yaml\(\)\.load" --include=*.{java,kt} .

# XXE
grep -rnE "DocumentBuilderFactory|SAXParserFactory|XMLInputFactory|TransformerFactory|Unmarshaller" --include=*.{java,kt} .

# SSRF / HTTP
grep -rnE "RestTemplate|WebClient|HttpURLConnection|OkHttpClient|URL\(" --include=*.{java,kt} .

# Crypto / secrets
grep -rnE "MD5|SHA-1|DES|ECB|Random\(\)|TrustAllCerts|setHostnameVerifier|AllowAllHostnameVerifier" --include=*.{java,kt} .

# SpEL / EL injection
grep -rnE "SpelExpressionParser|ExpressionParser|@Value\(.*#\{|Ognl|MVEL" --include=*.{java,kt} .
```

## Framework-specific (Spring)

- Missing `@PreAuthorize`/method security; `permitAll()` over-broad matchers.
- Actuator endpoints exposed (`/actuator/env`, `/heapdump`, `/jolokia`).
- Mass assignment via `@ModelAttribute` binding without `@InitBinder` allow-list.
- SpEL injection in `@Value`, `@Query`, or Thymeleaf expressions.
- Insecure deserialization in Spring Integration / RMI / JMS endpoints.
- Path traversal in `ResourceHttpRequestHandler` / `Resource` loading.
- CORS `allowedOrigins("*")` combined with `allowCredentials(true)`.

## Supply chain

```bash
mvn org.owasp:dependency-check-maven:check 2>/dev/null | tail -c 3000 \
  || ./gradlew dependencyCheckAnalyze 2>/dev/null | tail -c 3000
```
Flag Log4Shell-class, Jackson polymorphic-typing, and Commons-Collections gadget risks
only where a reachable sink exists.
