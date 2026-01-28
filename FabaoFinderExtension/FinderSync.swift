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
            // 1. Feedback Sonoro: Se ouvir um "Bip", o clique funcionou!
            NSSound.beep()
            
            // 2. Log no Console (Para debugarmos igual gente grande)
            NSLog("[FabaoDebug] Clicou no menu!")
            
            guard let target = FIFinderSyncController.default().targetedURL() else {
                NSLog("[FabaoDebug] Erro: Target é nil")
                return
            }
            
            NSLog("[FabaoDebug] Tentando criar em: %@", target.path)
            
            let fileURL = target.appendingPathComponent("novo_arquivo.txt")
            let text = "Funcionou caramba!\n"
            
            do {
                try text.write(to: fileURL, atomically: true, encoding: .utf8)
                NSLog("[FabaoDebug] SUCESSO! Arquivo criado.")
                // Tenta selecionar o arquivo criado
                NSWorkspace.shared.selectFile(fileURL.path, inFileViewerRootedAtPath: "")
            } catch {
                NSLog("[FabaoDebug] ERRO AO GRAVAR: %@", error.localizedDescription)
            }
        }
    
    
    
}
