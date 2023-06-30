import Foundation
import XCTest

@testable import ArchitectureSample

private final class Spy: MVCViewProtocol {
    enum Method {
        case updateList,
             showError
    }
    
    var methodsCalled: [Method] = []
    
    func updateList(list: [String]) {
        methodsCalled.append(.updateList)
    }
    
    func showError() {
        methodsCalled.append(.showError)
    }
}

final class MVCViewControllerSpec: XCTestCase {
    private lazy var sut = MVCFactory.build(sampleView: spy, useCase: useCaseStub)
    private let useCaseStub = RepoListUseCaseStub()
    private let spy = Spy()
    
    func test_WhenLoadController_ThenRequestSuccess_ShouldCallExpectedMethods() {
        useCaseStub.isSuccess = true
        
        sut.viewDidLoad()
        XCTAssertEqual(spy.methodsCalled, [.updateList])
    }
    
    func test_WhenLoadController_ThenRequestFail_ShouldCallExpectedMethods() {
        useCaseStub.isSuccess = false
        
        sut.viewDidLoad()
        XCTAssertEqual(spy.methodsCalled, [.showError])
    }
}
