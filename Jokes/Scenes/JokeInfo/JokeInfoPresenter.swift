//
//  JokeInfoPresenter.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol JokeInfoPresentationLogic {
    func presentJokeInfo(response: JokeInfo.getJokeInfo.Response)
    func presentTranslatedJoke(response: JokeInfo.translateJoke.Response)
}

class JokeInfoPresenter: JokeInfoPresentationLogic {
    weak var viewController: JokeInfoDisplayLogic?
    
    
    func presentJokeInfo(response: JokeInfo.getJokeInfo.Response) {
        let viewModel = JokeInfo.getJokeInfo.ViewModel(joke: response.joke)
        viewController?.displayJokeInfo(viewModel: viewModel)
    }
    
    func presentTranslatedJoke(response: JokeInfo.translateJoke.Response) {
        let viewModel = JokeInfo.translateJoke.ViewModel(translation: response.translations)
        viewController?.displayTranslatedJoke(viewModel: viewModel)
    }
}
