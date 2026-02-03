## Пример PlantUML!

```kroki-plantuml
@startuml
title Load docs page

actor User
participant "Web App" as WA
participant "API" as API
database "DB" as DB

User -> WA: Open page
WA -> API: GET /docs
API -> DB: SELECT pages
DB --> API: pages
API --> WA: JSON
WA --> User: Render
@enduml
```