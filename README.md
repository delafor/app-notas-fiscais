# Notas Fiscais

Aplicativo Flutter para gerenciamento de dados e fluxos relacionados a notas fiscais.

> **Status:** em preparação para produção. Use `docs/PRODUCTION_READINESS.md` como checklist de release.

## Stack

- Flutter / Dart
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- FVM para controle da versão do Flutter
- Flutter Test

As versões oficiais estão em `pubspec.yaml` e `.fvmrc`.

## Estrutura atual

```text
lib/
├── main.dart
├── pages/        # apresentação atual
├── gen/          # código gerado
├── theme.dart
└── firebase_options.dart
```

A arquitetura alvo e as regras de dependência estão em [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md). A migração deve ser incremental por feature, sem reescrever o projeto inteiro.

## Desenvolvimento

```bash
fvm flutter pub get
fvm flutter analyze
fvm flutter test
fvm flutter run
```

## Qualidade e produção

O projeto está em preparação para produção. Antes de publicar, complete [`docs/PRODUCTION_READINESS.md`](docs/PRODUCTION_READINESS.md) e feche os bloqueadores P0 das Issues.

## Documentação

- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) — arquitetura alvo.
- [`docs/PRODUCTION_READINESS.md`](docs/PRODUCTION_READINESS.md) — critérios de produção.
- [`docs/ROADMAP.md`](docs/ROADMAP.md) — roadmap.
- [`docs/SECURITY.md`](docs/SECURITY.md) — requisitos de segurança.
- [`docs/RELEASE.md`](docs/RELEASE.md) — checklist de release.
- [`docs/TODO.md`](docs/TODO.md) — backlog técnico.

## Definition of Done

Uma funcionalidade só está pronta quando comportamento, estados de erro, testes adequados e requisitos de segurança foram validados.

## Contribuição

1. Crie uma branch descritiva.
2. Faça mudanças pequenas e focadas.
3. Execute `fvm flutter analyze` e `fvm flutter test`.
4. Abra um Pull Request descrevendo problema, solução e como testar.

## Licença

A licença ainda não está definida neste repositório. Defina-a antes de uma distribuição pública.