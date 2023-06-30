import Foundation

@testable import ArchitectureSample

extension RepoListModel {
    static func fixture(name: String = "") -> RepoListModel {
        .init(name: "Sample")
    }
}
