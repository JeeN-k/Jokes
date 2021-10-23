//
//  NetworkService.swift
//  Jokes
//
//  Created by Oleg Stepanov on 21.10.2021.
//

import Foundation
import UIKit

protocol Networking {
    func getRequest(apiScheme: APIScheme, parameters: [String: String], completion: @escaping(Data?, Error?) -> ())
    func postRequest(apiScheme: APIScheme, headers: [String: String], parameters: [String : Any], completion: @escaping (Data?, Error?) -> ())
}

class NetworkService: Networking {
   
    func getRequest(apiScheme: APIScheme, parameters: [String : String], completion: @escaping (Data?, Error?) -> ()) {
        let url = self.url(from: apiScheme, parameters: parameters)
        
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func postRequest(apiScheme: APIScheme, headers: [String: String], parameters: [String : Any], completion: @escaping (Data?, Error?) -> ()) {
        let url = self.url(from: apiScheme, parameters: nil)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch let error {
            print(error.localizedDescription)
        }
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
    
    private func url(from apiScheme: APIScheme, parameters: [String: String]?) -> URL {
        var components = URLComponents()
        components.scheme = apiScheme.scheme
        components.host = apiScheme.host
        components.path = apiScheme.path
        
        guard let parameters = parameters else { return components.url! }
        
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        return components.url!
    }
    
}
