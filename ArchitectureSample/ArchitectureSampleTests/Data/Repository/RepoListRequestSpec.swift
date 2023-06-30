import Foundation
import XCTest

@testable import ArchitectureSample

final class RepoListRequestSpec: XCTestCase {
    private let sut = RepoListRequest()
    
    func test_PropertiesShouldReturnExpectedValues() {
        XCTAssertEqual(sut.encoding, .query)
        XCTAssertEqual(sut.path, "users/corabank/repos")
        XCTAssertEqual(sut.method, .get)
        XCTAssertNil(sut.params)
    }
}
