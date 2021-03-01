//
//  NetworkManager.swift
//  BusRoute
//
//  Created by Mayank Mathur on 24/02/21.
//  Copyright © 2021 Mayank Mathur. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager() // singleton
    private let dataURL = "https://open-app1.herokuapp.com/data"

    private init() {}
    
    func fetchBusRouteData<T: Codable>(completed: @escaping (Result<T, BRError>) -> Void) {
        
        guard let url = URL(string: dataURL) else {
            completed(Result.failure(.invalidRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(Result.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(Result.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(Result.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // specifies the type of decoding
                decoder.dateDecodingStrategy = .iso8601
                let route = try decoder.decode(T.self, from: data)
                completed(Result.success(route))
            } catch {
                completed(Result.failure(.invalidData))
            }
        }
        task.resume()
    }
}

enum BRError: String, Error {
    
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidRequest = "Invalid request. Please check and try again"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from the server was invalid. Please try again"
}
