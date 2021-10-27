//
//  JokePresenter.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import Foundation

protocol JokePresentationLogic {
    func presentJokes(response: Jokelist.FetchJokes.Response)
}

class JokePresenter: JokePresentationLogic {

    
    
    weak var viewController: JokesDisplayLogic?
    
    func presentJokes(response: Jokelist.FetchJokes.Response) {
        let joke = response.jokes
        let cells = joke.map { jokeItem in
            cellViewModel(from: jokeItem)
        }
        let jokeViewModel = JokeViewModel.init(cells: cells)
        let viewModel = Jokelist.FetchJokes.ViewModel(jokeViewModel: jokeViewModel, jokes: joke)
        viewController?.displayJokes(viewModel: viewModel)
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

