protocol RepoListRepositoryProtocol {
    func getRepoList(success: @escaping ([RepoListModel]) -> Void, failure: @escaping () -> Void)
}
