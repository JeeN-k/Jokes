//
//  JokeInfoWorker.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class JokeInfoService {
    var networking: Networking
    var fetcher: DataFetcher
    
    private var jokeItem: JokeItem?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getJokeInfo(jokeID: Int, completion: @escaping (JokeItem) -> ()) {
        fetcher.getJokeInfo(jokeID: jokeID) { [weak self] jokeItem in
            self?.jokeItem = jokeItem
            guard let jokeItem = jokeItem else { return }
            completion(jokeItem)
        }
    }
}
