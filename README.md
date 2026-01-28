# 📂 FabaoFileMenu - Finder Extension

Uma extensão nativa para macOS que adiciona a opção **"Criar Arquivo Texto"** ao menu de contexto (botão direito) do Finder.

# PORQUE CRIAR MINHA EXTENSÃO?

1. Conflito de Paradigmas: "App-Centric" vs. "Doc-Centric"
Mundo Windows/Linux (Doc-Centric): A lógica é: "Primeiro eu crio um objeto (arquivo) no lugar que eu quero, depois eu decido com quem vou editar." É por isso que o menu "Novo Arquivo" é nativo e sagrado nesses sistemas.

Mundo Apple (App-Centric): A lógica de Steve Jobs/NeXTSTEP sempre foi: "Primeiro você abre a ferramenta (App), faz o trabalho, e depois decide onde salvar."

Para a Apple, um arquivo de 0 bytes (vazio) é considerado "lixo" ou um erro de design. Eles acham que o usuário não deveria ter que gerenciar arquivos vazios.

2. O "Jardim Murado" (Sandbox e Segurança)
Antigamente (antes do macOS 10.10 Yosemite), era fácil fazer "hacks" que injetavam código no Finder. Mas isso causava instabilidade: se o hack travasse, o Finder (e o Desktop todo) travava junto.

A Apple criou a Finder Sync Extension API (essa que usamos) para isolar o seu código. Se sua extensão travar, o Finder continua vivo.

O Custo: Para ter essa segurança, eles bloquearam quase tudo. Por isso tivemos que fazer malabarismo com Entitlements e App Groups só para ter permissão de escrever um simples .txt na pasta do usuário.

3. A Falta de "Opções de Power User"
O macOS é focado no usuário comum. O usuário comum arrasta arquivos. O Dev/SRE (você) precisa criar arquivos de configuração (.yml, .json, .env, Dockerfile) rapido e no lugar certo.

A Apple oferece o Automator (que é lento e clunky) ou Atalhos (Shortcuts), mas nenhum deles é tão rápido e integrado ("native feel") quanto clicar com o botão direito e ver a opção lá instantaneamente.

Resumo: Por que você fez a sua?
Porque as soluções existentes eram:

Pagas: Apps como "New File Menu" na App Store custam dinheiro para fazer algo que deveria ser nativo.

Lentas: Scripts de Automator demoram 1 a 2 segundos para rodar.

Bloatware: Instalar apps gigantes só para ter um menu.

Você construiu a solução Raiz: código nativo (Swift), leve, rápido, sem pagar nada e com controle total do comportamento (como a lógica de (2).txt que acabamos de fazer).

Bem-vindo ao desenvolvimento nativo de macOS: É difícil porque é seguro, e não tem o que você quer porque a Apple acha que você não precisa. 😂

## Imagens

![alt text](doc/image-1.png)
Novos arquivos adicionados...


![alt text](doc/image.png)
Menu de contexto para adicionar novo arquivo....

> **Nota:** Este projeto é uma Proof of Concept (PoC) para demonstrar como superar as restrições de Sandbox do macOS e manipular arquivos diretamente via extensão do Finder.

## 🚀 Funcionalidades

- 🖱️ **Integração Nativa:** Aparece no menu de clique direito dentro das pastas.
- 📄 **Criação Rápida:** Cria um arquivo `novo_arquivo.txt` instantaneamente.
- 🔄 **Lógica de Colisão:** Se o arquivo já existir, cria automaticamente sequencialmente: `novo_arquivo(2).txt`, `novo_arquivo(3).txt`, etc.
- 🔊 **Feedback Sonoro:** Emite um som de sistema ("Bip") ao concluir a ação com sucesso.
- 🔓 **Bypass de Sandbox:** Utiliza *Entitlements* específicos para permitir escrita na pasta do usuário.

## ⚠️ Pré-requisitos de Ambiente

Antes de baixar o código, certifique-se de que você tem o ambiente de desenvolvimento Apple pronto na sua máquina.

1. **Xcode Instalado:**
   Você precisa do Xcode completo para compilar o projeto. Disponível gratuitamente na [Mac App Store](https://apps.apple.com/br/app/xcode/id497799835).
   
2. **Git:**
   Necessário para clonar o repositório (geralmente já vem instalado no macOS).

## 🛠️ Instalação e Configuração

### 1. Clonar o Repositório
Abra o terminal e baixe o código:

```bash
git clone git@github.com:slackwarecps/finder-menu-extension.git
cd finder-menu-extension
```

### 2. Configuração Obrigatória (Atenção ⚠️)
Como este projeto utiliza um caminho absoluto para driblar o Sandbox, você precisa configurar seu usuário manualmente antes de compilar. Se pular este passo, a extensão não terá permissão para criar arquivos.

Abra o projeto no Xcode (FabaoFileMenu.xcodeproj) ou use um editor de texto.

Navegue até o arquivo: `FabaoFinderExtension > FinderSync.swift`.

Localize o método `init()` e altere a linha do caminho para o seu usuário:

```swift
// 🔴 ALTERE AQUI: Troque "fabioalvaropereira" pelo seu nome de usuário real
let myRealHome = URL(fileURLWithPath: "/Users/SEU_USUARIO_AQUI")
```

## 🏗️ Como Compilar (Build)
Você pode compilar o projeto diretamente pelo terminal, sem precisar abrir a interface gráfica do Xcode.

Certifique-se de estar na raiz do projeto e execute:

```bash
xcodebuild -project FabaoFileMenu.xcodeproj \
           -scheme FabaoFileMenu \
           -configuration Debug \
           clean build
```

Se o comando finalizar com **BUILD SUCCEEDED**, o aplicativo foi gerado e registrado com sucesso.

## ✅ Como Ativar e Usar
O macOS instala novas extensões "desativadas" por padrão. Siga os passos para ligar:

**Ativar:**

1. Abra **Ajustes do Sistema** (System Settings).
2. Vá em **Privacidade e Segurança** > **Extensões**.
3. Clique em **Extensões do Finder** (Finder Extensions).
4. Marque a caixa ☑️ ao lado de **FabaoFileMenu**.

**Usar:**

1. Abra o Finder e navegue até sua pasta de usuário (ou qualquer subpasta dela).
2. Clique com o Botão Direito no espaço vazio da pasta.
3. Selecione a opção **"Criar Arquivo Texto (Fabão)"**.

## 🐛 Resolução de Problemas (Troubleshooting)
**O menu não aparece:**

- Verifique se a extensão está marcada nos Ajustes do Sistema.
- Reinicie o Finder forçadamente rodando no terminal:

```bash
killall Finder
```

**Ouço o "Bip" mas o arquivo não é criado:**

- Isso geralmente é erro de permissão ou caminho errado.
- Verifique se você alterou o caminho do usuário no `FinderSync.swift` corretamente.
- Verifique se o arquivo `.entitlements` está configurado no projeto.
