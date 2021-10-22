//
//  NetworkService.swift
//  Jokes
//
//  Created by Oleg Stepanov on 21.10.2021.
//

import Foundation
import UIKit

protocol Networking {
    func request(path: String, parameters: [String: String], completion: @escaping(Data?, Error?) -> ())
}

class NetworkService: Networking {
    
    func request(path: String, parameters: [String : String], completion: @escaping (Data?, Error?) -> ()) {
        let url = self.url(from: path, parameters: parameters)
        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping(Data?, Error?) -> ()) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
    private func url(from path: String, parameters: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = APIJoke.scheme
        components.host = APIJoke.host
        components.path = path
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
    
}
