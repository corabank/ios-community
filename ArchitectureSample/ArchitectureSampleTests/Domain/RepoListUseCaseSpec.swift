import Foundation
import XCTest

@testable import ArchitectureSample

private final class RepositoryStub: RepoListRepositoryProtocol {
    var isSuccess: Bool = false
    
    func getRepoList(success: @escaping ([RepoListModel]) -> Void, failure: @escaping () -> Void) {
        isSuccess ?
        success([RepoListModel.fixture()]) :
        failure()
    }
    
    
}

final class RepoListUseCaseSpec: XCTestCase {
    private lazy var sut = RepoListUseCase(repository: stub)
    private var stub = RepositoryStub()
    
    func test_WhenGetList_ThenSuccess_ShouldReceiveExpectedResponse() {
        stub.isSuccess = true
        
        var spy: [RepoInfo]?
        
        sut.getRepoList { list in
            spy = list
        } failure: {
            XCTFail("Unexpected result")
        }

        XCTAssertTrue(spy?.count == 1)
        XCTAssertEqual(spy?.first?.name, "Sample")
    }
    
    func test_WhenGetList_ThenFail_ShouldReceiveExpectedResponse() {
        stub.isSuccess = false
        
        var didFail: Bool = false
        
        sut.getRepoList { list in
            XCTFail("Unexpected result")
        } failure: {
            didFail = true
        }
        
        XCTAssertTrue(didFail)
    }
}
