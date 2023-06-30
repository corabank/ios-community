import UIKit

protocol MVCViewProtocol {
    func updateList(list: [String])
    func showError()
}

final class MVCView: UIView, MVCViewProtocol {
    func updateList(list: [String]) {
        print(list)
    }
    
    func showError() {
        print("fail")
    }
}
