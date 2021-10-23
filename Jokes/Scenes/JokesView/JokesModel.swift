//
//  JokesModel.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import Foundation


enum Jokelist {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getJokes
            }
        }
        struct Response {
            enum ResponseType {
                case presentJokes(joke: [JokeItem])
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayJokes(jokeViewModel: JokeViewModel, joke: [JokeItem])
            }
        }
    }
}

struct JokeViewModel {
    struct Cell: JokeCellViewModel {
        var category: String
        var joke: String
        var safebale: String
        var id: Int
    }
    let cells: [Cell]
}
