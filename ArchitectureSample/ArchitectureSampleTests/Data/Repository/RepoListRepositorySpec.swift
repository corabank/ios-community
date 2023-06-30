import Foundation
import XCTest

@testable import ArchitectureSample

private final class DataSourceStub: RemoteDataSourceProtocol {
    var isSuccess: Bool = false
    
    func fetch<T>(request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let json = "[{\"name\": \"Sample\"}]"
        
        if isSuccess, let data = json.data(using: .utf8),
           let decoded = try? JSONDecoder().decode([RepoListModel].self, from: data) as? T {
            completion(.success(decoded))
        } else {
            completion(.failure(ApiError.unknow))
        }
    }
}

final class RepoListRepositorySpec: XCTestCase {
    private lazy var sut = RepoListRepository(dataSource: stub)
    private var stub = DataSourceStub()
    
    func test_WhenFetch_ThenSuccess_ShouldReceiveExpectedResponse() {
        stub.isSuccess = true
        
        var spy: [RepoListModel]?
        
        sut.getRepoList { list in
            spy = list
        } failure: {
            XCTFail("Unexpected result")
        }

        
        XCTAssertTrue(spy?.count == 1)
        XCTAssertEqual(spy?.first?.name, "Sample")
    }
    
    func test_WhenFetch_ThenFail_ShouldReceiveExpectedResponse() {
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
