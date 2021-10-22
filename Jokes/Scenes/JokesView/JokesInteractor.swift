//
//  JokesIteractor.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import Foundation

protocol JokesBusinessLogic {
    func makeRequest(request: Jokelist.Model.Request.RequestType)
}

class JokesInteractor: JokesBusinessLogic {
    
    var presenter: JokePresentationLogic?
    var service: JokeWorker?
    
    
    func makeRequest(request: Jokelist.Model.Request.RequestType) {
        if service == nil {
            service = JokeWorker()
        }
        
        switch request {
        case .getJokes:
            service?.getJokes(completion: { jokeResponse in
                self.presenter?.presentData(response: .presentJokes(joke: jokeResponse))
            })
        }
        
    }
}
