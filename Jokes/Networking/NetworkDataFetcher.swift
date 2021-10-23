//
//  NetworkDataFetcher.swift
//  Jokes
//
//  Created by Oleg Stepanov on 21.10.2021.
//

import Foundation
import UIKit

protocol DataFetcher {
    func getJokes(response: @escaping([JokeItem]?) -> ())
    func getJokeInfo(jokeID: Int, response: @escaping(JokeItem?) -> ())
    func getTranslations(texts: [String], response: @escaping ([Translation]?) -> ())    
}

class NetworkDataFetcher: DataFetcher {
    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getJokes(response: @escaping ([JokeItem]?) -> ()) {
        let params = ["amount": "100"]
        let api = APIS.joke.getAPI()
        networking.getRequest(apiScheme: api, parameters: params) { data, error in
            if let error = error {
                print("Error data recieved \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: JokeResponse.self, from: data)
            response(decoded?.jokes)
        }
    }
    
    func getJokeInfo(jokeID: Int, response: @escaping (JokeItem?) -> ()) {
        let params = ["idRange": String(jokeID)]
        let api = APIS.joke.getAPI()
        networking.getRequest(apiScheme: api, parameters: params) { data, error in
            if let error = error {
                print("Error data recieved \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: JokeItem.self, from: data)
            response(decoded)
        }
    }
    
    func getTranslations(texts: [String], response: @escaping ([Translation]?) -> ()) {
        let params: [String: Any] = ["targetLanguageCode": "ru", "texts": texts]
        let headers = ["Authorization": APIScheme.yandexKey]
        let api = APIS.translate.getAPI()
        networking.postRequest(apiScheme: api, headers: headers, parameters: params) { data, error in
            if let error = error {
                print("Error data recieved \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: TranslateResponse.self, from: data)
            response(decoded?.translations)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = data, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
