//
//  NetworkManager.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 4/4/21.
//

import Foundation

enum NetworkError: Error {
    case error(String)
    case noInternet
    case failedToGetData
    case failedToDecodeData
}

func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
    let url = URL(string: "https://hackingwithswift.com/samples/friendface.json")!
    let request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error as NSError? {
            if error.code == NSURLErrorNotConnectedToInternet {
                completion(.failure(.noInternet))
            } else {
                completion(.failure(.error(error.localizedDescription)))
            }
        }
        
        guard let data = data else {
            completion(.failure(.failedToGetData))
            return
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        guard let userData = try? decoder.decode([User].self, from: data) else {
            completion(.failure(.failedToDecodeData))
            return
        }
        DispatchQueue.main.async {
            completion(.success(userData))
        }
        
    }
    
    task.resume()
}
