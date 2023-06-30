import UIKit

enum MVCFactory {
    static func build(sampleView: MVCViewProtocol = MVCView(),
                      useCase: RepoListUseCaseProtocol = RepoListUseCase()) -> UIViewController {
        MVCViewController(sampleView: sampleView,
                          useCase: useCase)
    }
}
