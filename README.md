# 📂 Finder Context Menu Extension (Swift)

Um exemplo prático de como adicionar uma opção personalizada ao menu de contexto (botão direito) do Finder no macOS, superando as restrições de Sandbox.

> **Status:** Proof of Concept (PoC) funcional.

## 🚀 O que ele faz
Adiciona uma opção **"Criar Arquivo Texto"** ao clicar com o botão direito em uma pasta no Finder.
- Cria um arquivo `novo_arquivo.txt` instantaneamente.
- Emite feedback sonoro (System Beep) ao concluir.
- Serve como base para automações mais complexas (scripts, templates, etc).

## 🛠️ Tecnologias
- **Swift 5**
- **Finder Sync Extension**
- **Xcode** (App Sandbox & Entitlements)

## ⚠️ Pré-requisitos e Avisos Importantes
Como este projeto lida com permissões de sistema e Sandbox, ele requer configuração manual antes de compilar.

### 1. Ajuste do Caminho (Hardcoded)
Devido às restrições de segurança do macOS, o `NSHomeDirectory()` dentro de uma extensão retorna o caminho do container, não o do usuário real.
Você **precisa** alterar o arquivo `FinderSync.swift` para o seu usuário:

```swift
// Em FinderSync.swift > override init()
let myRealHome = URL(fileURLWithPath: "/Users/SEU_USUARIO_AQUI")
