# Безопасность [API](../../glossary.md#abbr-005)

Безопасность API строится по принципу defense-in-depth: идентификация, авторизация, защита канала, контроль злоупотреблений и наблюдаемость.

## Уровни сложности

### Базовый уровень

- применять HTTPS/[TLS](../../glossary.md#abbr-088) и базовую токен-аутентификацию;
- различать аутентификацию и авторизацию;
- проверять критичные [JWT](../../glossary.md#abbr-046)-claims.

### Средний уровень

- выбирать [OAuth](../../glossary.md#abbr-056) flow под тип клиента;
- настраивать scopes per endpoint и rate limits;
- внедрять [mTLS](../../glossary.md#abbr-052) и rotation ключей.

### Продвинутый уровень

- реализовать zero-trust модель (service identity, SPIFFE/SPIRE);
- использовать JWS/JWE и централизованный key management;
- строить policy-as-code для API security governance.

## Базовые слои защиты

| Слой | Что защищает | Типовые механизмы |
| --- | --- | --- |
| Transport | канал связи | TLS 1.2+, mTLS, HSTS |
| Identity | кто вызывает API | OAuth 2.1, [OIDC](../../glossary.md#abbr-057), API keys |
| Authorization | что можно делать | scopes, [RBAC](../../glossary.md#abbr-069)/ABAC, policy engine |
| Abuse protection | защита от перегрузки и злоупотреблений | rate limiting, quotas, WAF |
| Data protection | защита payload | encryption at rest/in transit, masking |
| Audit | расследование инцидентов | immutable audit log, trace id |

## OAuth 2.1 и OIDC

### Выбор flow

| Сценарий | Рекомендованный flow |
| --- | --- |
| SPA/mobile | Authorization Code + PKCE |
| M2M сервисы | Client Credentials |
| Device/IoT | Device Authorization Grant |
| SSO пользовательских приложений | OIDC + Authorization Code |

### Поток Client Credentials

```kroki-plantuml
@startuml
actor ServiceA
participant "Auth Server" as AS
participant "Resource API" as API

ServiceA -> AS: POST /token (client_id, client_secret, scope)
AS --> ServiceA: access_token (JWT)
ServiceA -> API: GET /accounts Authorization: Bearer token
API -> API: Verify signature and claims
API --> ServiceA: 200 OK
@enduml
```

## [JWT](../../glossary.md#abbr-046): что проверять обязательно

- `iss` (issuer) и `aud` (audience);
- `exp`, `nbf`, `iat` (временные ограничения);
- `scope`/`roles` по конкретной операции;
- подпись через `kid` и JWKS endpoint;
- запрет `alg=none` и слабых алгоритмов.

### Пример JWT payload

```json
{
  "iss": "https://auth.example.com",
  "aud": "payments-api",
  "sub": "service:checkout",
  "scope": "payments.write payments.read",
  "exp": 1760000000,
  "iat": 1759996400
}
```

## JWS vs JWE

| Формат | Назначение |
| --- | --- |
| JWS | подпись, целостность, подлинность |
| JWE | шифрование payload (конфиденциальность) |

## Zero Trust: [mTLS](../../glossary.md#abbr-052) + SPIFFE

- каждому сервису выдается short-lived identity (SPIFFE ID);
- sidecar или gateway проверяет сертификат обеих сторон;
- сертификаты ротируются автоматически;
- network policy ограничивает lateral movement.

## Типовые угрозы и контрмеры

| Угроза | Контрмера |
| --- | --- |
| Replay attack | nonce, timestamp, idempotency key |
| Token leakage | short-lived tokens, secure storage, rotation |
| Injection | schema validation, input sanitization |
| CSRF | same-site cookies, anti-CSRF token |
| Brute force | adaptive throttling, CAPTCHA/WAF |
| Privilege escalation | least privilege, scoped tokens, ABAC |

## Инструменты

- Identity providers: Keycloak, Auth0, Okta;
- [API](../../glossary.md#abbr-005) Security/WAF: Cloudflare, AWS WAF, NGINX App Protect;
- Service identity: SPIRE, Istio mTLS;
- Secrets/keys: HashiCorp Vault, AWS KMS, Azure Key Vault.
## Стандарты и источники

- [OAuth](../../glossary.md#abbr-056) 2.1 draft: <https://datatracker.ietf.org/doc/draft-ietf-oauth-v2-1/>
- OpenID Connect Core: <https://openid.net/specs/openid-connect-core-1_0.html>
- [RFC](../../glossary.md#abbr-072) 7519 [JWT](../../glossary.md#abbr-046): <https://www.rfc-editor.org/rfc/rfc7519>
- RFC 7517 JWK: <https://www.rfc-editor.org/rfc/rfc7517>
- OWASP API Security Top 10: <https://owasp.org/API-Security/>
