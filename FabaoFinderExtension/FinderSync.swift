import Cocoa
import FinderSync

class FinderSync: FIFinderSync {

    override init() {
            super.init()
            
            // CORREÇÃO DO SANDBOX:
            // Em vez de pedir pro sistema (que mente o caminho), vamos cravar o caminho real.
            // Como seu usuário é "fabioalvaropereira", vamos direto nele.
            let myRealHome = URL(fileURLWithPath: "/Users/fabioalvaropereira")
            
            // Configura para monitorar sua Home real
            FIFinderSyncController.default().directoryURLs = [myRealHome]
            
            // Dica: Logs ajudam a ver se rodou (abra o Console.app e filtre por "Fabao")
            NSLog("FabaoFinderExtension: Monitorando a pasta %@", myRealHome.path)
        }

    // 1. Esse método cria o item no menu quando você clica com o botão direito
    override func menu(for menuKind: FIMenuKind) -> NSMenu? {
            // CORREÇÃO DEFINITIVA:
            // Use .contextualMenuForItems em vez de .contextualMenuForSelection
            
            if menuKind == .contextualMenuForContainer || menuKind == .contextualMenuForItems {
                let menu = NSMenu(title: "")
                let item = NSMenuItem(title: "Criar Arquivo Texto (Fabão)", action: #selector(createFile(_:)), keyEquivalent: "")
                item.target = self
                menu.addItem(item)
                return menu
            }
            return nil
        }

    // 2. A Ação efetiva (Versão com Debug)
@IBAction func createFile(_ sender: AnyObject?) {
        // 1. Feedback Sonoro (Bip)
        NSSound.beep()
        NSLog("[FabaoDebug] Clicou no menu!")
        
        // 2. Tenta pegar a pasta atual
        guard let target = FIFinderSyncController.default().targetedURL() else {
            NSLog("[FabaoDebug] Erro: Target é nil")
            return
        }
        
        // 3. Configuração do Nome Base
        let baseName = "novo_arquivo"
        let fileExtension = "txt"
        
        // Começamos com o padrão: novo_arquivo.txt
        var finalName = "\(baseName).\(fileExtension)"
        var fileURL = target.appendingPathComponent(finalName)
        var counter = 2
        
        // 4. Lógica de Colisão (O Pulo do Gato) 🐱
        // Enquanto existir um arquivo nesse caminho, a gente tenta o próximo número.
        // FileManager.default.fileExists checa se o path já está ocupado.
        while FileManager.default.fileExists(atPath: fileURL.path) {
            finalName = "\(baseName)(\(counter)).\(fileExtension)"
            fileURL = target.appendingPathComponent(finalName)
            counter += 1
        }
        
        NSLog("[FabaoDebug] Nome final calculado: %@", finalName)
        
        // 5. Conteúdo do arquivo (Personalizei para incluir o nome dentro dele)
        let text = "Este é o arquivo: \(finalName)\nCriado pela extensão do Fabão.\n"
        
        do {
            // Tenta escrever
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
            NSLog("[FabaoDebug] SUCESSO! Arquivo criado em: %@", fileURL.path)
            
        } catch {
            NSLog("[FabaoDebug] ERRO AO GRAVAR: %@", error.localizedDescription)
        }
    }
    
    
    
}
