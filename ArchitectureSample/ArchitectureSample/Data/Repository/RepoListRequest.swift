struct RepoListRequest: RequestProtocol {
    var path: String { "users/corabank/repos" }
    var method: RequestMethod { .get }
    var params: Encodable?
    var encoding: RequestEncode { .query }
}
