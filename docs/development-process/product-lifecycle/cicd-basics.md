# Основы CI/CD

CI/CD обеспечивает короткий и предсказуемый путь от изменения в репозитории до безопасного релиза.

## CI (Continuous Integration)

- частые merge в mainline;
- автоматическая сборка;
- unit/integration тесты;
- статический анализ и security scan.

## CD (Continuous Delivery/Deployment)

- автоматическая доставка в staging/prod;
- canary/blue-green стратегии;
- rollback и feature flags;
- post-deploy smoke checks.

## Пример pipeline

```kroki-plantuml
@startuml
start
:Commit/PR;
:Build + unit tests;
if (OK?) then (Да)
  :Integration + contract tests;
  if (OK?) then (Да)
    :Deploy staging;
    :Smoke tests;
    if (Release approved?) then (Да)
      :Deploy production;
      :Monitor and verify;
    else (Нет)
      :Hold release;
    endif
  else (Нет)
    :Fix defects;
  endif
else (Нет)
  :Fix build/tests;
endif
stop
@enduml
```

## Quality gates

- тестовое покрытие критичного кода;
- без блокирующих security findings;
- успешные контрактные тесты;
- соответствие DoD.
