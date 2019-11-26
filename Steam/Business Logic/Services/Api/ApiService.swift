//
//  ApiService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 19/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

// MARK: - Constants

private enum Constants {
    
    static let apiKey = "49BFF741A48A987B4040125D7D79BB87"

}

class ApiService {
    
    enum Error: Swift.Error {
        
        case noConnection
        
        case decodingError
        
        case unknown
        
    }
    
    enum Mocks {
        
        static let myId = "76561199004225368"
        
        static let somePersonId = "76561197967599040"
        
    }
    
    enum Endpoint: String {
        
        case api = "api.steampowered.com"
        
        case store = "store.steampowered.com"
        
    }

    // MARK: - Singleton

    static let shared = ApiService()

    private init() { }

}

// MARK: - Requests

extension ApiService {

    @discardableResult
    func request<T: Codable>(endpoint: Endpoint = .api,
                             url: String,
                             with parameters: [RequestParameter: Any] = [:],
                             needApiKey: Bool = false,
                             completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask? {

        var fullParameters = parameters.mapPairs { ($0.rawValue, $1) }
        
        if needApiKey {
            fullParameters = fullParameters + [
                "key": Constants.apiKey
            ]
        }

        let queryItems = fullParameters.map { key, value -> URLQueryItem in
            URLQueryItem(name: key, value: String(describing: value))
        }

        let urlComponents = NSURLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = endpoint.rawValue
        urlComponents.path = "/\(url)"
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { return nil }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error as NSError? {
                if error.domain == NSURLErrorDomain,
                   error.code == NSURLErrorNotConnectedToInternet {
                    completion(.failure(.noConnection))
                } else {
                    completion(.failure(.unknown))
                }
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let response = try decoder.decode(T.self, from: data)
                completion(.success(response))
            } catch {
                print(error as Any)
                fatalError("Decoding Error")
                completion(.failure(.decodingError))
            }
        }

        task.resume()

        return task
    }

}
