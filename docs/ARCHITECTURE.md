# Arquitetura

## Situação observada
O projeto Flutter concentra a aplicação em `lib/`, com páginas, tema, configuração Firebase e código gerado. A evolução recomendada é incremental, por feature.

## Estrutura alvo
```text
lib/
  app/
    app.dart
    router/
    theme/
  core/
    errors/
    network/
    storage/
    utils/
    widgets/
  features/
    auth/
      data/
      domain/
      presentation/
    notas_fiscais/
      data/
      domain/
      presentation/
```

## Regras
1. Widgets não devem conter regras de negócio complexas.
2. Widgets não devem acessar Firebase diretamente quando existir lógica de domínio.
3. Infraestrutura deve ficar em serviços/repositórios.
4. Contratos devem permitir testes sem depender de Firebase real.
5. Código gerado deve ficar isolado.
6. Migrar feature por feature; não reescrever tudo de uma vez.