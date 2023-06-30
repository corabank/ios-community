import UIKit

enum VIPFactory {
    static func build() -> UIViewController {
        let view = VIPViewController()
        let presenter = VIPPresenter(view: view)
        let interactor = VIPInteractor(presenter: presenter)
        
        view.interactor = interactor
        
        return view
    }
}
