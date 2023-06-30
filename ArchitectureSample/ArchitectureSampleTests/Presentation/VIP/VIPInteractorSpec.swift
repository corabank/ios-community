import Foundation
import XCTest

@testable import ArchitectureSample

private final class Spy: VIPPresenterProtocol {
    enum Method {
        case didReceive,
             showError
    }
    
    var methodsCalled: [Method] = []
    
    func didReceive(list: [RepoInfo]) {
        methodsCalled.append(.didReceive)
    }
    
    func showError() {
        methodsCalled.append(.showError)
    }
}

final class VIPInteractorSpec: XCTestCase {
    private lazy var sut = VIPInteractor(presenter: spy, useCase: useCaseStub)
    private let useCaseStub = RepoListUseCaseStub()
    private let spy = Spy()
    
    func test_WhenLoadInfo_ThenRequestSuccess_ShouldCallExpectedMethods() {
        useCaseStub.isSuccess = true
        
        sut.loadInfo()
        XCTAssertEqual(spy.methodsCalled, [.didReceive])
    }
    
    func test_WhenLoadInfo_ThenRequestFail_ShouldCallExpectedMethods() {
        useCaseStub.isSuccess = false
        
        sut.loadInfo()
        XCTAssertEqual(spy.methodsCalled, [.showError])
    }
}
