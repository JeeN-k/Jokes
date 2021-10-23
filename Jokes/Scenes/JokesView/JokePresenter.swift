//
//  JokePresenter.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import Foundation

protocol JokePresentationLogic {
    func presentData(response: Jokelist.Model.Response.ResponseType)
}

class JokePresenter: JokePresentationLogic {
    
    weak var viewController: JokesDisplayLogic?
    
    func presentData(response: Jokelist.Model.Response.ResponseType) {
        switch response {
        case .presentJokes(let joke):
            let cells = joke.map { jokeItem in
                cellViewModel(from: jokeItem)
            }
            let jokeViewModel = JokeViewModel.init(cells: cells)
            viewController?.display(viewModel: .displayJokes(jokeViewModel: jokeViewModel, joke: joke))
        }
    }
    
    private func cellViewModel(from jokeItem: JokeItem) -> JokeViewModel.Cell {
        var safable = ""
        var jokePart = ""
        if jokeItem.safe {
            safable = "Safe"
        } else {
            safable = "Not safe"
        }
        if let joke = jokeItem.joke {
            jokePart = joke
        } else if let joke = jokeItem.setup {
            jokePart = joke
        }
        return JokeViewModel.Cell.init(category: jokeItem.category, joke: jokePart, safebale: safable, id: jokeItem.id)
    }
    
}

