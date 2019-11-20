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

    static let baseUrlHost = "api.steampowered.com"

}

class ApiService {
    
    enum Mocks {
        
        static let myId = "76561199004225368"
        
        static let somePersonId = "76561197960435530"
        
    }

    // MARK: - Singleton

    static let shared = ApiService()

    private init() { }

}

// MARK: - Requests

extension ApiService {

    @discardableResult
    func request<T: Codable>(url: String,
                             with parameters: [RequestParameter: Any] = [:],
                             needApiKey: Bool = false,
                             completion: @escaping (T) -> Void) -> URLSessionDataTask? {

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
        urlComponents.host = Constants.baseUrlHost
        urlComponents.path = "/\(url)"
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { return nil }

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            guard let steamResponse = try? JSONDecoder().decode(SteamResponse<T>.self, from: data) else { return }
            guard let response = steamResponse.response else { return }
            completion(response)
        }

        task.resume()

        return task
    }

}
