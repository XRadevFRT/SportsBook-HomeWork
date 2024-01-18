//
//  NetworkClient.swift
//  SportsBook-HomeWork
//
//  Created by Radoslav Radev  on 17.01.24.
//

import Foundation

final class NetworkClient: NetworkClientProtocol {
    func sendRequest<T: Decodable>(_ request: NetworkRequestProtocol,
                                   completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let urlRequest = try buildURLRequest(from: request)
            performRequest(with: urlRequest) { result in
                switch result {
                case .success(let data):
                    self.decodeResponse(data: data, completion: completion)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch {
            if let error = error as? NetworkError {
                completion(.failure(error))
            }
        }
    }

    func buildURLRequest(from request: NetworkRequestProtocol) throws -> URLRequest {
        guard let baseURL = request.baseURL,
              baseURL.isValid(),
              let url = URL(string: baseURL.absoluteString + request.path) else {
            throw NetworkError.invalidURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers

        if let parameters = request.parameters {
            do {
                if JSONSerialization.isValidJSONObject(parameters) {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                } else {
                    throw NetworkError.encodingFailed
                }
            } catch {
                throw NetworkError.encodingFailed
            }
        }

        return urlRequest
    }

    func performRequest(with urlRequest: URLRequest,
                        completion: @escaping (Result<Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completion(.failure(.requestFailed(statusCode: -1, data: nil)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                    (200..<300).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                completion(.failure(.requestFailed(statusCode: statusCode, data: data)))
                return
            }

            if let data = data, !data.isEmpty {
                completion(.success(data))
            } else {
                completion(.failure(.unexpectedResponse))
            }

        }.resume()
    }

    func decodeResponse<T: Decodable>(data: Data,
                                      completion: @escaping (Result<T, NetworkError>) -> Void) {
        do {
            let decodedModel = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedModel))
        } catch {
            completion(.failure(.decodingFailed))
        }
    }
}
