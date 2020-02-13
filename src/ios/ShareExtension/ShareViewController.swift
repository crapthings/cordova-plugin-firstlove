import MobileCoreServices
import UIKit

class ShareViewController: UIViewController {
    @IBOutlet weak var textarea: UITextView!
    @IBOutlet weak var done: UIButton!
    
    var userDefaults = UserDefaults(suiteName: "group.com.idibwofa6eg9w4.bk46f44qira.share")!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urls: [String] = []
 
        guard let extensionItems = extensionContext?.inputItems as? [NSExtensionItem] else {
            return
        }
        
        let group = DispatchGroup()

        for extensionItem in extensionItems {
            if let itemProviders = extensionItem.attachments {
                for itemProvider in itemProviders {
                    group.enter()
                    itemProvider.loadItem(forTypeIdentifier: kUTTypeItem as String, options: nil, completionHandler: { text, error in
                        urls.append("\(text!)")
                        let filename = (text as? URL)?.lastPathComponent
                        self.textarea.insertText("\(filename!)\n\(text!)\n\n")
                        group.leave()
                    })
                }
            }
        }
        
        group.notify(queue: .main) {
            self.userDefaults.set(urls, forKey: "urls")
            self.userDefaults.synchronize()
            self.textarea.insertText("done \(urls) \n\n")
            self.openURL(URL(string:"openwith://test")!)
            self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        }
    }
 
    @IBAction func btn(_ sender: UIButton) {
        self.openURL(URL(string:"openwith://test")!)
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    @objc func openURL(_ url: URL) -> Bool {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        return false
    }
}
