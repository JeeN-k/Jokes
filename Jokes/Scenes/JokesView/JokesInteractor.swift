//
//  JokesIteractor.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import Foundation

protocol JokesBusinessLogic {
    func getJokes(request: Jokelist.FetchJokes.Request)
    func selectJoke(requst: Jokelist.SelectJoke.Request)
}

protocol JokesDataStore {
    var jokes: [JokeItem] { get set }
    var selectedJoke: JokeItem? { get set }
}

class JokesInteractor: JokesBusinessLogic, JokesDataStore {
    var presenter: JokePresentationLogic?
    var service: JokesService?
    
    var selectedJoke: JokeItem?
    var jokes: [JokeItem] = []
    
    func getJokes(request: Jokelist.FetchJokes.Request) {
        if service == nil {
            service = JokesService()
        }
        
        service?.getJokes(completion: { jokeResponse in
            self.jokes = jokeResponse
            let response = Jokelist.FetchJokes.Response(jokes: jokeResponse)
            self.presenter?.presentJokes(response: response)
        })
    }
    
    func selectJoke(requst: Jokelist.SelectJoke.Request) {
        guard !jokes.isEmpty else { return }
        
        self.selectedJoke = jokes[requst.index]
    }
}
