# 🧾 Notas Fiscais

Aplicativo desenvolvido em Flutter para **organizar, armazenar e facilitar o gerenciamento de notas fiscais**, transformando um processo que normalmente fica espalhado entre papéis, fotos, e-mails e arquivos em uma experiência centralizada.

O projeto nasceu com uma ideia simples: **tornar o controle de notas fiscais mais fácil no dia a dia**.

Com a evolução do projeto, essa ideia abriu espaço para algo muito maior: uma plataforma capaz de conectar organização financeira, documentos, garantias e inteligência sobre compras em um único lugar.

> 🚧 **Status:** projeto em evolução e em preparação para produção.

---

## 📱 Sobre o projeto

O **Notas Fiscais** foi criado para resolver um problema comum: guardar uma nota fiscal é fácil; **encontrar, organizar e utilizar essa informação depois** é muito mais difícil.

A proposta do aplicativo é criar uma central pessoal para os documentos fiscais do usuário, permitindo que as informações importantes fiquem organizadas e acessíveis.

O projeto também explora uma experiência moderna de aplicativo, com autenticação, armazenamento em nuvem, recursos relacionados a notas e uma base preparada para receber novas funcionalidades.

---

## ✨ Principais funcionalidades

### 🧾 Gerenciamento de notas fiscais

- Cadastro e organização de notas fiscais.
- Consulta das informações cadastradas.
- Armazenamento de documentos e imagens.
- Visualização das notas dentro do aplicativo.
- Estrutura preparada para evolução do histórico de compras.

### 🔐 Autenticação

- Login de usuários.
- Integração com Firebase Authentication.
- Suporte à autenticação por provedores externos.
- Armazenamento seguro de informações sensíveis no dispositivo quando necessário.

### ☁️ Armazenamento em nuvem

- Firebase Firestore para dados.
- Firebase Storage para arquivos e imagens.
- Estrutura preparada para sincronização dos dados do usuário.

### 📷 Captura e leitura

- Suporte à seleção de imagens.
- Scanner baseado em câmera para recursos relacionados a documentos.
- Base preparada para evoluir para leitura automatizada de informações fiscais.

### 🎨 Interface

- Interface construída em Flutter.
- Tema centralizado.
- Componentes reutilizáveis.
- Suporte a diferentes tamanhos de tela.
- Estrutura preparada para evolução do Design System.

### 🖥️ Multiplataforma

A base do projeto é Flutter, permitindo evolução para diferentes plataformas conforme a necessidade do produto.

---

## 🧠 Visão do produto

Mais do que guardar uma nota fiscal, a proposta é **transformar a nota em informação útil**.

Uma nota pode representar:

- uma compra;
- um produto;
- uma garantia;
- uma despesa;
- um estabelecimento;
- uma oportunidade de economia;
- um histórico de consumo.

Por isso, o projeto foi estruturado pensando não somente no armazenamento do documento, mas também em tudo que pode ser construído a partir dos dados presentes nele.

---

## 🚀 Tecnologias utilizadas

| Tecnologia | Utilização |
|---|---|
| **Flutter** | Desenvolvimento multiplataforma |
| **Dart** | Linguagem principal |
| **Firebase Authentication** | Autenticação |
| **Cloud Firestore** | Banco de dados |
| **Firebase Storage** | Armazenamento de arquivos |
| **FVM** | Controle da versão do Flutter |
| **Flutter Test** | Testes automatizados |
| **FlutterGen** | Geração e organização de assets |

As versões e dependências oficiais estão definidas em `pubspec.yaml` e `.fvmrc`.

---

## 🏗️ Estrutura do projeto

A estrutura atual está em processo de evolução para uma arquitetura mais organizada por funcionalidades.

```text
lib/
├── main.dart
├── pages/              # telas e apresentação atual
├── gen/                # código gerado
├── theme.dart          # tema global
└── firebase_options.dart
```

A arquitetura alvo está documentada em [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md), com uma migração incremental por feature para evitar uma reescrita desnecessária do projeto.

---

## ⚙️ Como executar o projeto

### Pré-requisitos

- Flutter instalado.
- FVM instalado.
- Android Studio ou VS Code.
- Um dispositivo Android/iOS ou emulador configurado.
- Configuração válida do Firebase.

### Instalação

```bash
fvm flutter pub get
```

### Análise do código

```bash
fvm flutter analyze
```

### Executar testes

```bash
fvm flutter test
```

### Executar o aplicativo

```bash
fvm flutter run
```

---

## 🔥 Firebase

O aplicativo utiliza Firebase como parte importante da infraestrutura.

Antes de executar ou publicar uma versão do aplicativo, verifique:

- Firebase Authentication;
- Firestore;
- Storage;
- regras de segurança;
- configurações por ambiente;
- permissões e isolamento dos dados dos usuários.

As regras de segurança são tratadas como requisito de produção e não devem depender apenas da interface do aplicativo.

---

## 🧪 Qualidade e testes

O objetivo do projeto é chegar a uma base em que funcionalidades críticas sejam acompanhadas por testes automatizados.

Os principais fluxos que devem possuir cobertura incluem:

- autenticação;
- cadastro de notas;
- consulta de notas;
- persistência de dados;
- upload de documentos;
- tratamento de erros;
- recuperação de falhas de rede;
- permissões e segurança.

O checklist completo está em [`docs/PRODUCTION_READINESS.md`](docs/PRODUCTION_READINESS.md).

---

## 🔒 Segurança

Como o aplicativo trabalha com documentos e dados de compras, segurança é uma parte essencial do produto.

Entre os pontos necessários para uma versão de produção estão:

- regras corretas de Firestore e Storage;
- autenticação e autorização adequadas;
- proteção de informações sensíveis;
- ausência de segredos privados no código-fonte;
- controle de acesso aos dados por usuário;
- logs sem exposição de informações fiscais sensíveis.

Mais detalhes em [`docs/SECURITY.md`](docs/SECURITY.md).

---

## 🗺️ Roadmap

### Fase 1 — Base do produto

- [x] Estrutura inicial Flutter.
- [x] Autenticação.
- [x] Integração com Firebase.
- [x] Base para gerenciamento de notas.
- [x] Tema e interface inicial.

### Fase 2 — Preparação para produção

- [ ] Revisão de segurança Firebase.
- [ ] Testes dos fluxos críticos.
- [ ] CI com análise, testes e build.
- [ ] Tratamento global de erros.
- [ ] Padronização dos estados de interface.
- [ ] Refatoração arquitetural incremental.

### Fase 3 — Evolução do produto

- [ ] Leitura inteligente de informações das notas.
- [ ] Busca e filtros avançados.
- [ ] Histórico de compras.
- [ ] Organização por categorias.
- [ ] Recursos relacionados a garantias.
- [ ] Estatísticas e insights sobre gastos.
- [ ] Compartilhamento de informações.
- [ ] Experiência multiplataforma cada vez mais completa.

O roadmap detalhado está em [`docs/ROADMAP.md`](docs/ROADMAP.md).

---

## 📚 Documentação

- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) — arquitetura e organização desejadas.
- [`docs/PRODUCTION_READINESS.md`](docs/PRODUCTION_READINESS.md) — checklist para produção.
- [`docs/ROADMAP.md`](docs/ROADMAP.md) — evolução planejada do produto.
- [`docs/SECURITY.md`](docs/SECURITY.md) — requisitos de segurança.
- [`docs/RELEASE.md`](docs/RELEASE.md) — processo de release.
- [`docs/TODO.md`](docs/TODO.md) — backlog técnico.

---

## 🤝 Contribuição

A evolução do projeto deve seguir algumas regras simples:

1. Criar uma branch específica para cada mudança.
2. Manter commits pequenos e descritivos.
3. Evitar misturar refatorações grandes com novas funcionalidades.
4. Executar análise e testes antes de abrir um Pull Request.
5. Documentar mudanças importantes de arquitetura ou comportamento.

---

## 📌 Filosofia do projeto

O objetivo nunca foi criar apenas mais um aplicativo para armazenar fotos de notas fiscais.

A ideia é construir uma **base de dados pessoal de compras**, onde cada documento possa gerar informações úteis para o usuário.

A nota fiscal deixa de ser apenas um arquivo guardado e passa a ser uma fonte de dados.

---

## 🌱 De onde surgiu a próxima ideia

Durante a evolução deste projeto, ficou claro que o problema poderia ser muito maior do que simplesmente organizar notas fiscais.

As notas carregam informações sobre produtos, preços, estabelecimentos, compras e garantias. A partir disso surgiu a ideia de transformar essa experiência em um projeto **maior, mais completo e com muito mais potencial**, conectando organização de compras, vida financeira, histórico de produtos, benefícios e inteligência sobre os dados do consumidor.

Portanto, este projeto não representa apenas um aplicativo de notas fiscais.

Ele foi a **base e o ponto de partida para uma ideia maior**.

---

## 📄 Licença

A licença ainda não foi definida. Antes de uma distribuição pública, definir a licença e os termos de uso do projeto.

---

<p align="center">
  Desenvolvido com Flutter e muita vontade de transformar uma ideia simples em um produto maior. 🚀
</p>
