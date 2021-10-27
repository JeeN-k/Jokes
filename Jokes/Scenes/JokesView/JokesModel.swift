//
//  JokesModel.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import Foundation


enum Jokelist {
    enum FetchJokes {
        struct Request {
        }
        struct Response {
            var jokes: [JokeItem]    
        }
        struct ViewModel {
            var jokeViewModel: JokeViewModel
            var jokes: [JokeItem]
        }
    }
    
    enum SelectJoke {
        struct Request {
            let index: Int
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
