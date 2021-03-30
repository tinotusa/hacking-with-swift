//
//  NetworkManager.swift
//  CupcakeCorner
//
//  Created by Tino on 30/3/21.
//

import Foundation

class NetworkManager {
    enum NetworkError: String, Error {
        case failedToDecode = "Failed to decode data"
        case failedToFetch = "Failed to fetch data"
        case invalidResponse = "Invalid response from server"
    }
    
    static func placeOrder(order: Order, completion: @escaping (Result<Order, NetworkError>) -> Void) {
        guard let encodedData = try? JSONEncoder().encode(order) else {
            completion(.failure(.failedToDecode))
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        request.httpBody = encodedData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completion(.failure(.failedToFetch))
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                completion(.success(decodedOrder))
            } else {
                completion(.failure(.failedToFetch))
            }
        }
        task.resume()
    }
}
