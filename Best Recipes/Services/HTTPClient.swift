//
//  NetworkManager.swift
//  Best Recipes
//
//  Created by dsm 5e on 03.07.2024.
//

import Foundation

// MARK: - Apikeys
 enum ApiKeys: String, CaseIterable {
    case one
    case two
    case three
    case four
    case five
     
     var rawValue: String {
         switch self {
         case .one:
             return ProcessInfo.processInfo.environment["KEY_ONE"] ?? ""
         case .two:
             return ProcessInfo.processInfo.environment["KEY_TWO"] ?? ""
         case .three:
             return ProcessInfo.processInfo.environment["KEY_THREE"] ?? ""
         case .four:
             return ProcessInfo.processInfo.environment["KEY_FOUR"] ?? ""
         case .five:
             return ProcessInfo.processInfo.environment["KEY_FIVE"] ?? ""
         }
     }
}

// MARK: - Methods
 enum HTTPMethod: String {
    case GET, POST
}

//MARK: - Errors
enum HTTPClientError: Error, LocalizedError {
    case badURL
    case badDataTask
    case badParametrSerialization
    case badDecode
    case deadApiKey

    var errorDescription: String? {
        switch self {
        case .badURL:
            return "УРЛ не валидный."
        case .badDataTask:
            return "Запрос завершился с ошибкой."
        case .badParametrSerialization:
            return "Переданы неверные параметры."
        case .badDecode:
            return "Невозможно декодировать дату."
        case .deadApiKey:
            return "Смените апи ключ."
        }
    }
}

protocol HTTPClient {
    var apiKey: ApiKeys { get }
    var baseURL: String { get }
    var path: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
    var data: Data? { get }

    func request<T: Codable>(type: T.Type, completion: @escaping (Result<T, HTTPClientError>) -> Void)
}

extension HTTPClient {
    func request<T: Codable>(type: T.Type, completion: @escaping (Result<T, HTTPClientError>) -> Void) {
        guard let url = URL(string: baseURL + path + endpoint) else {
            completion(.failure(.badURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .reloadIgnoringLocalCacheData

        if let data = data {
            let boundary = UUID().uuidString
            var requestData = Data()

            if let parameters = parameters {
                for (key, value) in parameters {
                    requestData.append("--\(boundary)\r\n".data(using: .utf8)!)
                    requestData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                    requestData.append("\(value)\r\n".data(using: .utf8)!)
                }
            }

            requestData.append("--\(boundary)\r\n".data(using: .utf8)!)
            requestData.append("Content-Disposition: form-data; name=\"image\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            requestData.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            requestData.append(data)
            requestData.append("\r\n".data(using: .utf8)!)
            requestData.append("--\(boundary)--\r\n".data(using: .utf8)!)
            request.httpBody = requestData
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(.badDataTask))
                return
            }

            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 402:
                    completion(.failure(.deadApiKey))
                    return
                default:
                    break
                }
            }

            if let data = data {
                do {
                    completion(.success(try JSONDecoder().decode(type, from: data)))
                } catch {
                    completion(.failure(.badDecode))
                    return
                }
            } else {
                completion(.failure(.badDataTask))
            }
        }

        dataTask.resume()
    }
}
