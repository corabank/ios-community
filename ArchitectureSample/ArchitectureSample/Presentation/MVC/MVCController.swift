import UIKit

final class MVCViewController: UIViewController {
    private let sampleView: MVCViewProtocol
    private let useCase: RepoListUseCaseProtocol
    
    // MARK: Initialization
    init(sampleView: MVCViewProtocol = MVCView(), useCase: RepoListUseCaseProtocol = RepoListUseCase()) {
        self.sampleView = sampleView
        self.useCase = useCase
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    // MARK: Life cycle
    override func loadView() {
        view = sampleView as? UIView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        useCase.getRepoList { [sampleView] repoList in
            sampleView.updateList(list: repoList.map { $0.name} )
        } failure: { [sampleView] in
            sampleView.showError()
        }
    }
}
