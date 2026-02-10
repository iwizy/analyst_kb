# Основы безопасности

Security для аналитика это не отдельный этап, а требования, которые вшиваются в продукт и интеграции с самого начала.

## Уровни сложности

### Базовый уровень

- понимать различие аутентификации и авторизации;
- учитывать защиту данных в transit и at rest;
- проверять требования по OWASP Top 10.

### Средний уровень

- формулировать security AC для API и UI;
- учитывать RBAC/ABAC, аудит и ротацию секретов;
- работать с требованиями GDPR/PCI DSS/локальных регуляторов.

### Продвинутый уровень

- участвовать в threat modeling;
- управлять security trade-off в архитектуре;
- внедрять security-by-design и zero trust практики.

## 1. Authentication & Authorization

- OAuth 2.0 / OIDC для пользовательских сценариев.
- JWT: проверка `exp`, `aud`, `iss`, `sub`.
- mTLS для межсервисного взаимодействия.
- RBAC/ABAC для разграничения доступа.

## 2. Data Protection

- TLS 1.2/1.3 для передачи данных.
- AES-256 и KMS/HSM для хранения.
- PII классификация и data minimization.
- secure cookies, CSRF protection, session policies.

## 3. Secure design и разработка

- OWASP Top 10 и secure coding guidelines.
- least privilege и secure defaults.
- input validation и output encoding.
- регулярные security review и pentest.

## 4. Secrets management

- no secrets in code;
- отдельные окружения и ротация ключей;
- Vault/Secrets Manager/KMS;
- аудит доступа к секретам.

## 5. Logging & Monitoring

- audit log критичных действий;
- корреляция событий через `correlation_id`;
- SIEM и аномалии;
- incident response runbook.

## Пример security-требований к API

| Область | Требование |
| --- | --- |
| Токены | access token 15 минут, refresh token rotation |
| Транспорт | mTLS для service-to-service |
| Доступ | scopes per endpoint + RBAC |
| Защита от abuse | rate limiting + idempotency key |
| Аудит | логирование изменений профиля и платежей |

## Угроза -> влияние -> mitigation

| Угроза | Влияние | Mitigation |
| --- | --- | --- |
| Replay attack | повтор операций | nonce + idempotency key + short TTL |
| Token theft | несанкционированный доступ | short-lived JWT + key rotation + mTLS |
| SQL injection | компрометация данных | parametrized queries + WAF + SAST |
| Privilege escalation | доступ к чужим данным | RBAC/ABAC + audit + periodic review |

## Типичные ошибки

- "безопасность потом";
- неограниченный срок жизни токенов;
- отсутствие сегрегации прав в админ-функциях;
- логирование чувствительных данных в открытом виде.

## Кросс-ссылки

- [Безопасность API](../integrations/api-design/security.md)
- [Идемпотентность](../integrations/api-design/idempotency.md)
- [Информационная безопасность](../architecture/information-security/index.md)

## Чек-лист для аналитика

- какие данные считаются чувствительными и где хранятся;
- кто имеет доступ и по какому основанию;
- как фиксируются и расследуются инциденты;
- какие регуляторные требования применимы в домене.

## Контрольные вопросы

1. Почему RBAC не всегда достаточно без ABAC?
2. Какие claims JWT обязательны для проверки?
3. Что вы добавите в требования, чтобы предотвратить replay атаки?

## Источники

- OWASP Top 10: <https://owasp.org/www-project-top-ten/>
- NIST CSF: <https://www.nist.gov/cyberframework>
- CIS Controls: <https://www.cisecurity.org/controls>
- ISO/IEC 27001: <https://www.iso.org/isoiec-27001-information-security.html>
- PCI DSS: <https://www.pcisecuritystandards.org/>

## Дата обновления

Февраль 2026.
