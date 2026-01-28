# 📂 FabaoFileMenu - Finder Extension

Uma extensão nativa para macOS que adiciona a opção **"Criar Arquivo Texto"** ao menu de contexto (botão direito) do Finder.

> **Nota:** Este projeto é uma Proof of Concept (PoC) para demonstrar como superar as restrições de Sandbox do macOS e manipular arquivos diretamente via extensão do Finder.

## 🚀 Funcionalidades

- 🖱️ **Integração Nativa:** Aparece no menu de clique direito dentro das pastas.
- 📄 **Criação Rápida:** Cria um arquivo `novo_arquivo.txt` instantaneamente.
- 🔊 **Feedback:** Emite um som de sistema ao concluir a ação.
- 🔓 **Bypass de Sandbox:** Utiliza *Entitlements* específicos para permitir escrita na pasta do usuário.

## ⚠️ Pré-requisitos (Configuração Obrigatória)

Como este projeto utiliza um caminho absoluto para driblar o Sandbox, **você precisa configurar seu usuário manualmente** antes de compilar.

1. Abra o projeto no Xcode.
2. Navegue até o arquivo: `FabaoFinderExtension` > `FinderSync.swift`.
3. Localize o método `init()` e altere a linha do caminho para o **seu usuário**:

```swift
// 🔴 ALTERE AQUI: Troque "fabioalvaropereira" pelo seu nome de usuário
let myRealHome = URL(fileURLWithPath: "/Users/SEU_USUARIO_AQUI")