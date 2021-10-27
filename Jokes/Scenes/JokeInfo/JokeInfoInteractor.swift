//
//  JokeInfoInteractor.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol JokeInfoBusinessLogic {
    func getJokeInfo(request: JokeInfo.getJokeInfo.Request)
    func translateJoke(request: JokeInfo.translateJoke.Request)
}

protocol JokeInfoDataStore {
    var jokeInfo: JokeItem? { get set }
}

final class JokeInfoInteractor: JokeInfoBusinessLogic, JokeInfoDataStore {
    var jokeInfo: JokeItem?
    var presenter: JokeInfoPresentationLogic?
    var service: JokeInfoService?
    
    func getJokeInfo(request: JokeInfo.getJokeInfo.Request) {
        guard let jokeInfo = jokeInfo else {
            return
        }
        let response = JokeInfo.getJokeInfo.Response(joke: jokeInfo)
        presenter?.presentJokeInfo(response: response)
    }
    
    func translateJoke(request: JokeInfo.translateJoke.Request) {
        if service == nil {
            service = JokeInfoService()
        }
        service?.getTraslations(from: request.texts, completion: { translations in
            let response = JokeInfo.translateJoke.Response(translations: translations)
            self.presenter?.presentTranslatedJoke(response: response)
        })
    }
}
