//
//  JokeInfoInteractor.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol JokeInfoBusinessLogic {
    func makeRequest(request: JokeInfo.Model.Request.RequestType)
}

class JokeInfoInteractor: JokeInfoBusinessLogic {
    
    var presenter: JokeInfoPresentationLogic?
    var service: JokeInfoService?
    
    func makeRequest(request: JokeInfo.Model.Request.RequestType) {
        if service == nil {
            service = JokeInfoService()
        }
        switch request {
        case .getJokeInfo(let jokeId):
            service?.getJokeInfo(jokeID: jokeId, completion: { jokeItem in
                self.presenter?.presentData(response: .presentJoke(joke: jokeItem))
            })
        }
    }
    
}
