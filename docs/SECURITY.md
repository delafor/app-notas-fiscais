# Segurança

- Nunca versionar secrets privados.
- Firebase client config não substitui autorização no backend.
- Validar acesso por usuário/empresa nas Rules.
- Não confiar apenas na UI para autorização.
- Minimizar dados pessoais e fiscais armazenados.
- Não registrar CPF/CNPJ, tokens, credenciais ou conteúdo fiscal completo em logs.
- Auditar Firestore Rules e Storage Rules antes de cada release.
- Testar usuário não autenticado, autenticado sem permissão e sessão expirada.

Em caso de exposição de segredo: revogar/rotacionar, corrigir a origem, avaliar impacto e registrar o incidente.