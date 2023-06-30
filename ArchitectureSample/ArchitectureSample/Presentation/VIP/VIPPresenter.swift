protocol VIPPresenterProtocol {
    func didReceive(list: [RepoInfo])
    func showError()
}

struct VIPPresenter: VIPPresenterProtocol {
    private weak var view: VIPViewControllerProtocol?
    
    init(view: VIPViewControllerProtocol) {
        self.view = view
    }
    
    func didReceive(list: [RepoInfo]) {
        view?.updateList(list: list.map { $0.name })
    }
    
    func showError() {
        view?.showError(message: "Fail")
    }
}
