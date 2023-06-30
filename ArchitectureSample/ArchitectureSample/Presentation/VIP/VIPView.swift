import UIKit

protocol VIPViewControllerProtocol: AnyObject {
    func updateList(list: [String])
    func showError(message: String)
}

final class VIPViewController: UIViewController, VIPViewControllerProtocol {
    var interactor: VIPInteractorProtocol?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.loadInfo()
    }
    
    // MARK: View Protocol
    func updateList(list: [String]) {
        print(list)
    }
    
    func showError(message: String) {
        print(message)
    }
}
