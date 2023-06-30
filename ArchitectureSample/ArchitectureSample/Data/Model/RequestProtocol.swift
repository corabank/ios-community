enum RequestMethod: String {
    case get = "GET",
         post = "POST"
}

enum RequestEncode {
    case query,
         json
}

protocol RequestProtocol {
    var path: String { get }
    var method: RequestMethod { get }
    var params: Encodable? { get }
    var encoding: RequestEncode { get }
}
