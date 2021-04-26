//
//  NetworkManager.swift
//  CupcakeCorner
//
//  Created by Tino on 26/4/21.
//

import SwiftUI

enum NetworkError: Error {
    case error(Error), serverError(HTTPURLResponse), decodingError(Error)
}

struct NetworkManager {
    static func sendOrder(data: Data, completion: @escaping (Result<OrderDetails, NetworkError>) -> Void) {
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.uploadTask(with: request, from: data) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.error(error)))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200 ..< 299).contains(httpResponse.statusCode)
            else {
                DispatchQueue.main.async {
                    // is this ok to force cast
                    completion(.failure(.serverError(response as! HTTPURLResponse)))
                }
                return
            }
            
            let decoder = JSONDecoder()
            
            if let mimeType = httpResponse.mimeType,
               mimeType == "application/json"
            {
                if let data = data {
                    do {
                        let order = try decoder.decode(OrderDetails.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(order))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(.decodingError(error)))
                        }
                    }
                }
            }
        }
        
        task.resume()
    }
}
