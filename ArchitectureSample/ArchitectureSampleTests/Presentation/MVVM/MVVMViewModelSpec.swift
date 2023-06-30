import Foundation
import XCTest

@testable import ArchitectureSample

private final class Spy {    
    enum Method {
        case updateList,
             showError
    }
    
    private var viewModel: MVVMViewModelProtocol
    
    var methodsCalled: [Method] = []
    
    init(viewModel: MVVMViewModelProtocol) {
        self.viewModel = viewModel
        configBindings()
    }
    
    private func configBindings() {
        viewModel.showError = { [weak self] _ in
            self?.methodsCalled.append(.showError)
        }
        
        viewModel.updateList = { [weak self] _ in
            self?.methodsCalled.append(.updateList)
        }
    }
}

final class MVVMViewModelSpec: XCTestCase {
    private lazy var sut = MVVMViewModel(useCase: useCaseStub)
    private let useCaseStub = RepoListUseCaseStub()
    
    func test_WhenLoadInfo_ThenRequestSuccess_ShouldCallExpectedMethods() {
        useCaseStub.isSuccess = true
        
        let spy = Spy(viewModel: sut)
        sut.loadInfo()

        XCTAssertEqual(spy.methodsCalled, [.updateList])
    }
    
    func test_WhenLoadInfo_ThenRequestFail_ShouldCallExpectedMethods() {
        useCaseStub.isSuccess = false
        
        let spy = Spy(viewModel: sut)
        sut.loadInfo()
        
        XCTAssertEqual(spy.methodsCalled, [.showError])
    }
}
