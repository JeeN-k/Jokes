//
//  JokeWorker.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import Foundation

class JokesService {
    var networking: Networking
    var fetcher: DataFetcher
    
    private var jokeResponse: [JokeItem]?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getJokes(completion: @escaping ([JokeItem]) -> ()) {
        fetcher.getJokes(response: { [weak self] jokeResponse in
            self?.jokeResponse = jokeResponse
            guard let jokeResponse = jokeResponse else { return }
            completion(jokeResponse)
        })
    }
}


