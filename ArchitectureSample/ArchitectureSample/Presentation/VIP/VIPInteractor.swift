protocol VIPInteractorProtocol {
    func loadInfo()
}

final class VIPInteractor: VIPInteractorProtocol {
    private let presenter: VIPPresenterProtocol,
                useCase: RepoListUseCaseProtocol
    
    init(presenter: VIPPresenterProtocol,
         useCase: RepoListUseCaseProtocol = RepoListUseCase()) {
        self.presenter = presenter
        self.useCase = useCase
    }
    
    func loadInfo() {
        useCase.getRepoList { [presenter] repoList in
            presenter.didReceive(list: repoList)
        } failure: { [presenter] in
            presenter.showError()
        }
    }
}
