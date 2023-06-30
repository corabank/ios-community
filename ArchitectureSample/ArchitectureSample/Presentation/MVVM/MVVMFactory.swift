import UIKit

enum MVVMFactory {
    static func build() -> UIViewController {
        let viewModel = MVVMViewModel()
        let view = MVVMViewController(viewModel: viewModel)
        
        return view
    }
}
