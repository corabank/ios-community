protocol MVVMViewModelProtocol {
    var updateList: (([String]) -> Void)? { get set }
    var showError: ((String) -> Void)? { get set }
    
    func loadInfo()
}

final class MVVMViewModel: MVVMViewModelProtocol {
    private let useCase: RepoListUseCaseProtocol
    
    init(useCase: RepoListUseCaseProtocol = RepoListUseCase()) {
        self.useCase = useCase
    }
    
    var updateList: (([String]) -> Void)?
    var showError: ((String) -> Void)?
    
    func loadInfo() {
        useCase.getRepoList { [updateList] repoList in
            updateList?(repoList.map { $0.name })
        } failure: { [showError] in
            showError?("Fail")
        }
    }
}
