# 🧾 Notas Fiscais

> Aplicativo mobile desenvolvido em Flutter para organizar, consultar e gerenciar notas fiscais e informações relacionadas às compras do usuário.

O **Notas Fiscais** nasceu com uma proposta simples: transformar a organização de notas fiscais em uma experiência mais prática, centralizada e acessível.

O projeto foi desenvolvido como uma aplicação real, explorando Flutter, Firebase, autenticação, armazenamento de dados, leitura de informações e uma interface pensada para uso no dia a dia.

---

## 🎯 Objetivo do projeto

O objetivo é permitir que o usuário mantenha suas notas fiscais organizadas em um único lugar, evitando depender de papéis, fotos espalhadas na galeria ou diferentes aplicativos para encontrar uma compra antiga.

A ideia é construir uma experiência em que registrar, consultar e gerenciar informações fiscais seja rápido e intuitivo.

---

## ✨ Principais funcionalidades

### 🧾 Gerenciamento de notas fiscais

- Cadastro e consulta de notas fiscais.
- Organização das informações das compras.
- Visualização dos dados de uma nota.
- Estrutura preparada para evolução das funcionalidades fiscais.

### 📷 Captura e leitura

- Utilização da câmera para recursos relacionados às notas.
- Leitura de códigos/QR Codes quando aplicável.
- Upload e armazenamento de imagens.

### 🔐 Autenticação

- Login de usuários.
- Integração com Firebase Authentication.
- Suporte a autenticação por provedores configurados no projeto.
- Estrutura preparada para controle de acesso por usuário.

### ☁️ Armazenamento em nuvem

- Firebase Cloud Firestore para dados da aplicação.
- Firebase Storage para arquivos e imagens.
- Estrutura preparada para sincronização dos dados do usuário.

### 🎨 Interface

- Interface desenvolvida em Flutter.
- Tema centralizado.
- Componentes reutilizáveis.
- Experiência pensada para dispositivos móveis.

### 🆘 Suporte e informações

O projeto também possui estrutura para recursos de ajuda, orientação ao usuário e evolução da experiência dentro do aplicativo.

---

## 🛠️ Tecnologias utilizadas

| Tecnologia | Utilização |
|---|---|
| **Flutter** | Desenvolvimento da aplicação |
| **Dart** | Linguagem principal |
| **Firebase Authentication** | Autenticação |
| **Cloud Firestore** | Banco de dados |
| **Firebase Storage** | Armazenamento de arquivos |
| **Mobile Scanner** | Leitura de códigos/QR Codes |
| **Flutter Secure Storage** | Armazenamento seguro local |
| **FVM** | Gerenciamento da versão do Flutter |
| **Flutter Test** | Testes automatizados |

As dependências e versões utilizadas ficam definidas no `pubspec.yaml` e o projeto possui configuração de versão do Flutter através do FVM.

---

## 📁 Estrutura atual do projeto

```text
app-notas-fiscais/
│
├── android/              # Configuração Android
├── ios/                  # Configuração iOS
├── linux/                # Configuração Linux
├── macos/                # Configuração macOS
├── assets/               # Imagens e recursos visuais
├── test/                 # Testes
│
├── lib/
│   ├── main.dart         # Entrada da aplicação
│   ├── firebase_options.dart
│   ├── theme.dart        # Tema da aplicação
│   ├── gen/              # Código gerado
│   └── pages/            # Telas da aplicação
│
├── .fvmrc                # Versão do Flutter utilizada
├── analysis_options.yaml # Regras de análise/lint
├── pubspec.yaml          # Dependências e configuração
└── README.md
```

A arquitetura atual está em evolução. O próximo estágio do projeto é organizar as funcionalidades por domínio/feature, reduzindo o acoplamento entre interface, regras de negócio e infraestrutura.

---

## 🚀 Como executar o projeto

### Pré-requisitos

- Flutter instalado ou FVM configurado.
- Dart compatível com a versão definida no projeto.
- Android Studio ou VS Code.
- Um dispositivo Android/iOS ou emulador.
- Configuração do Firebase correspondente ao ambiente.

### Clonar o projeto

```bash
git clone https://github.com/delafor/app-notas-fiscais.git
cd app-notas-fiscais
```

### Instalar dependências

Com FVM:

```bash
fvm flutter pub get
```

Ou com Flutter instalado globalmente:

```bash
flutter pub get
```

### Executar

```bash
fvm flutter run
```

### Verificar o projeto

```bash
fvm flutter analyze
fvm flutter test
```

---

## 🔥 Firebase

O aplicativo utiliza serviços do Firebase para recursos essenciais da aplicação.

Entre os serviços utilizados estão:

- **Firebase Authentication**
- **Cloud Firestore**
- **Firebase Storage**

Antes de executar o projeto em outro ambiente, é necessário configurar corretamente os arquivos e recursos do Firebase.

> **Importante:** regras de segurança do Firestore e Storage devem ser tratadas como parte crítica do projeto. Nunca dependa exclusivamente da interface do aplicativo para controlar acesso a dados.

---

## 🏗️ Arquitetura

A arquitetura atual foi construída de forma incremental durante o desenvolvimento do aplicativo.

O próximo estágio busca aproximar o projeto de uma estrutura mais escalável, com separação clara entre:

```text
Feature
├── Presentation
├── Domain
└── Data
```

A intenção é evitar que telas tenham responsabilidade direta por regras de negócio ou acesso à infraestrutura, facilitando manutenção, testes e evolução do produto.

---

## 🧪 Qualidade e testes

A aplicação possui uma pasta de testes e utiliza o framework de testes do Flutter.

Para uma versão de produção, o projeto deve evoluir para uma estratégia de testes cobrindo principalmente:

- autenticação;
- cadastro de informações;
- consulta de notas;
- persistência de dados;
- leitura de códigos;
- tratamento de erros;
- estados de loading e vazio;
- falhas de rede;
- permissões e segurança.

---

## 🔒 Segurança

Por trabalhar com informações relacionadas a compras e documentos fiscais, segurança é uma parte fundamental do produto.

Entre os pontos previstos para produção estão:

- regras de acesso no Firebase;
- isolamento de dados por usuário;
- proteção de informações sensíveis;
- armazenamento seguro de credenciais e tokens;
- tratamento de sessão expirada;
- logs sem exposição de dados privados;
- revisão das permissões do aplicativo.

---

## 💡 O que este projeto representa

Mais do que um aplicativo de notas fiscais, este projeto serviu como um laboratório real para aprender e colocar em prática conceitos de desenvolvimento mobile, Firebase, autenticação, banco de dados, armazenamento, UI e arquitetura de software.

Durante sua evolução, a ideia começou a mostrar que o problema poderia ser muito maior do que simplesmente **guardar uma nota fiscal**.

A necessidade de organizar compras, produtos, valores, documentos e informações do consumidor abriu espaço para uma visão de produto muito mais ampla.

---

## 🚀 Próximo nível

Este projeto acabou dando origem à ideia de um **produto maior, mais completo e com muito mais potencial**, capaz de transformar o conceito de gerenciamento de notas fiscais em uma plataforma de organização das compras do usuário.

A experiência adquirida aqui serviu como base para imaginar uma solução mais completa, com mais automação, inteligência, estatísticas, organização financeira e recursos voltados para o uso real no dia a dia.

Em outras palavras:

> **O Notas Fiscais foi o começo de uma ideia maior.**

O projeto mostrou o problema, revelou oportunidades e criou a base técnica para pensar em uma próxima geração do produto.

---

## 👨‍💻 Autor

Desenvolvido por **Edinaldo Oliveira**.

Projeto criado com foco em aprendizado prático, desenvolvimento mobile e construção de soluções que possam evoluir para produtos reais.

---

