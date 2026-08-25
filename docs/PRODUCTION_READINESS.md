# Production Readiness

Checklist mínimo antes de uma release de produção.

## Qualidade
- [ ] `flutter analyze` sem erros.
- [ ] Testes automatizados verdes.
- [ ] Lint e formatação padronizados.
- [ ] Código duplicado e morto removido.

## Arquitetura
- [ ] UI separada de regras de negócio e infraestrutura.
- [ ] Firebase acessado por serviços/repositórios quando houver regra de negócio.
- [ ] Navegação, configuração e dependências centralizadas.
- [ ] Código gerado separado do código manual.

## Segurança
- [ ] Firestore Rules auditadas.
- [ ] Storage Rules auditadas.
- [ ] Autorização validada no backend.
- [ ] Nenhum segredo privado versionado.
- [ ] Logs não expõem dados fiscais, tokens ou credenciais.

## Confiabilidade
- [ ] Loading, empty e error states em operações assíncronas.
- [ ] Falhas de rede tratadas.
- [ ] Retry seguro onde aplicável.
- [ ] Crash reporting/logging configurados.

## Testes
- [ ] Regras de negócio críticas cobertas.
- [ ] Fluxos de autenticação cobertos.
- [ ] Fluxos de nota fiscal cobertos.
- [ ] Casos inválidos e falhas de rede cobertos.

## Release
- [ ] CI executa analyze, test e build.
- [ ] Versão/build number atualizados.
- [ ] Build de release validado.
- [ ] Configurações de produção conferidas.
- [ ] Checklist pós-release preparado.

## Definition of Done
Uma funcionalidade só está pronta quando comportamento, erros, testes, segurança e qualidade foram validados de acordo com o risco.