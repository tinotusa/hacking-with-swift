//
//  NetworkManager.swift
//  BucketList
//
//  Created by Tino on 30/4/21.
//

import Foundation

enum NetworkError: Error {
    case url, server(Error), response(URLResponse), decoding(Error)
}


func loadJSON<T>(from urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void)
    where T: Decodable
{
    guard let url = URL(string: urlString) else {
        completion(.failure(.url))
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            DispatchQueue.main.async {
                completion(.failure(.server(error)))
            }
            return
        }
        if let data = data {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
                return
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decoding(error)))
                }
            }
        }
    }
    
    task.resume()
    
    
}
