# Диаграмма последовательности

Диаграмма последовательности (Sequence Diagram) показывает обмен сообщениями
между участниками во времени. Она особенно полезна для моделирования API,
интеграционных сценариев и обработки ошибок.

## Основные элементы

- Actor/Participant: внешние и внутренние участники.
- Lifeline: жизненная линия участника.
- Message: вызов (синхронный/асинхронный) и ответ.
- Activation: период выполнения операции.
- Frames: `alt`, `opt`, `loop`, `par` для сложной логики.

## Пример: логин через внешний OAuth-провайдер

```kroki-plantuml
@startuml
actor User
participant WebApp
participant AuthService
participant OAuthProvider
participant UserService

User -> WebApp : Ввод логина
WebApp -> AuthService : POST /login
AuthService -> OAuthProvider : validateToken()
OAuthProvider --> AuthService : token valid
AuthService -> UserService : getUserProfile()
UserService --> AuthService : profile
AuthService --> WebApp : access + refresh token
WebApp --> User : Успешный вход
@enduml
```

## Пример альтернативного сценария (`alt`)

```kroki-plantuml
@startuml
participant WebApp
participant AuthService

WebApp -> AuthService : POST /login
alt token valid
  AuthService --> WebApp : 200 OK
else token invalid
  AuthService --> WebApp : 401 Unauthorized
end
@enduml
```

## Как строить

1. Определите участников и границы сценария.
1. Пройдите основной поток от первого запроса до результата.
1. Добавьте ошибки/таймауты через `alt`.
1. Для повторяемых шагов используйте `loop`.
1. Отметьте, где вызов синхронный, а где асинхронный.

## Типичные ошибки

- сообщения без понятного инициатора или получателя;
- отсутствие негативных сценариев и компенсаций;
- смешение бизнес-описания и низкоуровневых сетевых деталей.

## Чек-лист качества

- По диаграмме можно восстановить sequence API-вызовов.
- Альтернативные исходы покрыты явно.
- Названия сообщений совпадают с контрактами интерфейсов.
