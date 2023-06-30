protocol RepoListUseCaseProtocol {
    func getRepoList(success: @escaping([RepoInfo]) -> Void, failure: @escaping() -> Void)
}

final class RepoListUseCase: RepoListUseCaseProtocol {
    private let repository: RepoListRepositoryProtocol
    
    init(repository: RepoListRepositoryProtocol = RepoListRepository()) {
        self.repository = repository
    }
    
    func getRepoList(success: @escaping([RepoInfo]) -> Void, failure: @escaping() -> Void) {
        repository.getRepoList(success: { model in
            success(model.map { RepoInfo(name: $0.name) })
        }, failure: failure)
    }
}
