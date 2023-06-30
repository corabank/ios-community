import Foundation

protocol RemoteDataSourceProtocol {
    func fetch<T: Decodable>(request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void)
}

final class RemoteDataSource: RemoteDataSourceProtocol {
    private let client: ApiClientProtocol
    
    init(client: ApiClientProtocol = ApiClient()) {
        self.client = client
    }
    
    func fetch<T: Decodable>(request: RequestProtocol, completion: @escaping (Result<T, Error>) -> Void) {
        client.fetch(request: request) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    print(error)
                    completion(.failure(ApiError.unknow))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
