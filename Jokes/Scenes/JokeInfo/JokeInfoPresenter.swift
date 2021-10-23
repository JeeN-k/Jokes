//
//  JokeInfoPresenter.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol JokeInfoPresentationLogic {
    func presentData(response: JokeInfo.Model.Response.ResponseType)
}

class JokeInfoPresenter: JokeInfoPresentationLogic {
    weak var viewController: JokeInfoDisplayLogic?
    
    func presentData(response: JokeInfo.Model.Response.ResponseType) {
        switch response {
        case .presentTranslation(let tranlations):
            viewController?.display(viewModel: .dispalyTranslation(translation: tranlations))
        }
    }
    
}
