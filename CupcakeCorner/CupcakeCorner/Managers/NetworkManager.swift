//
//  NetworkManager.swift
//  CupcakeCorner
//
//  Created by Tino on 30/3/21.
//

import Foundation

class NetworkManager {
    enum NetworkError: Error {
        case error(String)
        case noConnection
        case failedToDecode
        case failedToFetch
        case invalidResponse
    }
    
    static func placeOrder(order: Order, completion: @escaping (Result<Order, NetworkError>) -> Void) {
        guard let encodedData = try? JSONEncoder().encode(order) else {
            completion(.failure(.error("Failed to decode order")))
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        request.httpBody = encodedData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            switch error {
            case .some(let error as NSError) where error.code == NSURLErrorNotConnectedToInternet:
                completion(.failure(.noConnection))
                return
            case .some(let error):
                completion(.failure(.error(error.localizedDescription)))
            default:
                break
            }
            
            guard let data = data else {
                completion(.failure(.failedToFetch))
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                completion(.success(decodedOrder))
            } else {
                completion(.failure(.failedToDecode))
            }
        }
        task.resume()
    }
}
