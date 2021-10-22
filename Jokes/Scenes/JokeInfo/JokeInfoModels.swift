//
//  JokeInfoModels.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum JokeInfo {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getJokeInfo(jokeId: Int)
            }
        }
        struct Response {
            enum ResponseType {
                case presentJoke(joke: JokeItem)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayJoke(jokeItem: JokeItem)
            }
        }
    }   
}
