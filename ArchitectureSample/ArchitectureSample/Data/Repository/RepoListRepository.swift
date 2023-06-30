final class RepoListRepository: RepoListRepositoryProtocol {
    private let dataSource: RemoteDataSourceProtocol
    
    init(dataSource: RemoteDataSourceProtocol = RemoteDataSource()) {
        self.dataSource = dataSource
    }
    
    func getRepoList(success: @escaping ([RepoListModel]) -> Void, failure: @escaping () -> Void) {
        dataSource.fetch(request: RepoListRequest()) { (result: Result<[RepoListModel], Error>) in
            switch result {
            case .success(let response):
                success(response)
            case .failure:
                failure()
            }
        }
    }
}
