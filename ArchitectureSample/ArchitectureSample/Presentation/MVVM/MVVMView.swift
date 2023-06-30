import UIKit

final class MVVMViewController: UIViewController {
    private var viewModel: MVVMViewModelProtocol
    
    // MARK: Initialization
    init(viewModel: MVVMViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configBindings()
        viewModel.loadInfo()
    }
    
    private func configBindings() {
        viewModel.updateList = { list in
            print(list)
        }
        
        viewModel.showError = { message in
            print(message)
        }
    }
}
