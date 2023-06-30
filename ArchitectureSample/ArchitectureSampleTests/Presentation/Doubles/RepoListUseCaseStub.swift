@testable import ArchitectureSample

final class RepoListUseCaseStub: RepoListUseCaseProtocol {
    var isSuccess: Bool = false
    
    func getRepoList(success: @escaping ([RepoInfo]) -> Void, failure: @escaping () -> Void) {
        isSuccess ?
        success([.init(name: "Sample")]) :
        failure()
    }
}
