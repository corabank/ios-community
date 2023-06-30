import Foundation

protocol ApiClientProtocol {
    func fetch(request: RequestProtocol, completion: @escaping (Result<Data, ApiError>) -> Void)
}

final class ApiClient: ApiClientProtocol {
    func fetch(request: RequestProtocol, completion: @escaping (Result<Data, ApiError>) -> Void) {
        guard let url = URL(string: Environment.baseUrl + request.path) else {
            completion(.failure(ApiError.unknow))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in

            guard error == nil else {
                completion(.failure(ApiError.unknow))
                return
            }

            guard let data = data else {
                completion(.failure(ApiError.unknow))
                return
            }

            completion(.success(data))
        }

        dataTask.resume()
    }
}
