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
                case translateText(texts: [String])
            }
        }
        struct Response {
            enum ResponseType {
                case presentTranslation(tranlations: [Translation])
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case dispalyTranslation(translation: [Translation])
            }
        }
    }   
}
