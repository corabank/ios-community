import Foundation
import XCTest

@testable import ArchitectureSample

private struct RequestDummy: RequestProtocol {
    var path: String { "/sample" }
    var method: RequestMethod { .get }
    var params: Encodable?
    var encoding: RequestEncode { .query }
}

private final class ApiClientStub: ApiClientProtocol {
    var isSuccess: Bool = false,
        hasUnexpectedData: Bool = false
    
    func fetch(request: RequestProtocol, completion: @escaping (Result<Data, ApiError>) -> Void) {
        let json = hasUnexpectedData ? "{}" : "[{\"name\": \"Sample\"}]"
        
        if isSuccess, let data = json.data(using: .utf8) {
            completion(.success(data))
        } else {
            completion(.failure(ApiError.unknow))
        }
    }
}

final class RemoteDataSourceSpec: XCTestCase {
    private lazy var sut = RemoteDataSource(client: stub)
    private var stub = ApiClientStub()
    
    func test_WhenFetch_ThenSuccess_ShouldReceiveExpectedResponse() throws {
        stub.isSuccess = true
        
        var spy: Result<[RepoListModel], Error>?
        
        sut.fetch(request: RequestDummy()) { (result: Result<[RepoListModel], Error>) in
            spy = result
        }
        
        if case let .success(response) = spy {
            XCTAssertEqual(response.count, 1)
            XCTAssertEqual(response.first?.name, "Sample")
        } else {
            XCTFail("Unexpected result")
        }
    }
    
    func test_WhenFetch_ThenFail_ShouldReceiveExpectedResponse() {
        stub.isSuccess = false
        
        var spy: Result<[RepoListModel], Error>?
        
        sut.fetch(request: RequestDummy()) { result in
            spy = result
        }
        
        if case let .failure(error) = spy {
            XCTAssertTrue(error is ApiError)
        } else {
            XCTFail("Unexpected result")
        }
    }
    
    func test_WhenFetch_ThenSuccessWithUnexpectedData_ShouldFail() {
        stub.isSuccess = true
        stub.hasUnexpectedData = true
        
        var spy: Result<[RepoListModel], Error>?
        
        sut.fetch(request: RequestDummy()) { result in
            spy = result
        }
        
        if case let .failure(error) = spy {
            XCTAssertTrue(error is ApiError)
        } else {
            XCTFail("Unexpected result")
        }
    }
}
