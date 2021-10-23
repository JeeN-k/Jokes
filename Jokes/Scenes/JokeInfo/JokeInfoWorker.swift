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
    private var translation: [Translation]?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }
    
    func getTraslations(from texts: [String], completion: @escaping([Translation]) -> ()) {
        fetcher.getTranslations(texts: texts) { [weak self] translation in
            self?.translation = translation
            guard let translation = translation else { return }
            completion(translation)
        }
    }
}
