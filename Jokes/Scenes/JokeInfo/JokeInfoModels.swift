//
//  JokeInfoModels.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum JokeInfo {
    
    enum getJokeInfo {
        struct Request {

        }
        struct Response {
            var joke: JokeItem
        }
        struct ViewModel {
            var joke: JokeItem
        }
    }
    
    enum translateJoke {
        struct Request{
            var texts: [String]
        }
        struct Response {
            var translations: [Translation]
        }
        struct ViewModel {
            var translation: [Translation]
        }
    }
}
