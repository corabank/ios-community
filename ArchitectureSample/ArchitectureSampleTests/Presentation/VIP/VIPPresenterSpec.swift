import Foundation
import XCTest

@testable import ArchitectureSample

private final class Spy: VIPViewControllerProtocol {
    enum Method {
        case updateList,
             showError
    }
    
    var methodsCalled: [Method] = []
    
    func updateList(list: [String]) {
        methodsCalled.append(.updateList)
    }
    
    func showError(message: String) {
        methodsCalled.append(.showError)
    }
}

final class VIPPresenterSpec: XCTestCase {
    private lazy var sut = VIPPresenter(view: spy)
    private let spy = Spy()
    
    func test_ReceiveInfo_ShouldCallExpectedMethods() {
        sut.didReceive(list: [.init(name: "Sample")])
        XCTAssertEqual(spy.methodsCalled, [.updateList])
    }
    
    func test_WhenShowErrorsCalled_ShouldCallExpectedMethods() {
        sut.showError()
        XCTAssertEqual(spy.methodsCalled, [.showError])
    }
}
