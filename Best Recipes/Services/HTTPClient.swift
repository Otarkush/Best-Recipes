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
enum HTTPClientError: Error {
    case badURL
    case badDataTask
    case badParametrSerialization
    case badDecode
    case deadApiKey
}

// MARK: - ClientProtocol
 protocol HTTPClient {
    var apiKey: ApiKeys { get }
    var baseURL: String { get }
    var path: String { get }
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
}

extension HTTPClient {
    var url: String {
        return baseURL + path + endpoint
    }
        
    func request<T:Codable>(type: T.Type, completion: @escaping (Result<T, HTTPClientError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        print("URL: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.cachePolicy = .reloadIgnoringLocalCacheData
        print("REQUEST: \(request)")

        if let parameters = parameters {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
            } catch {
                completion(.failure(.badParametrSerialization))
                return
            }
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
                default:
                    break
                }
            }
        }

        dataTask.resume()
    }
}
