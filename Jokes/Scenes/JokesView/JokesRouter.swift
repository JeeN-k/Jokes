//
//  JokesRouter.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import UIKit

protocol JokesRoutingLogic {
    func routeToJokeInfo(segue: UIStoryboardSegue?)
}

protocol JokeDataPassing {
    var dataStore: JokesDataStore? { get }
}

class JokeRouter: NSObject, JokesRoutingLogic, JokeDataPassing {
    var dataStore: JokesDataStore?
    weak var viewController: JokesViewController?
    
    // MARK: Routing
    func routeToJokeInfo(segue: UIStoryboardSegue?)
    {
        if let segue = segue {
            guard
                let homeDS = dataStore,
                let detailVC = segue.destination as? JokeInfoViewController,
                var detailDS = detailVC.router?.dataStore
            else { fatalError("Fail route to detail") }
            
            passDataToJokeInfo(source: homeDS, destination: &detailDS)
        } else {
            guard
                let viewController = viewController,
                let homeDS = dataStore,
                let storyboard = viewController.storyboard,
                let detailVC = storyboard.instantiateViewController(withIdentifier: "JokeInfo") as? JokeInfoViewController,
                var detailDS = detailVC.router?.dataStore
            else { return }
            
            passDataToJokeInfo(source: homeDS, destination: &detailDS)
            navigateToJokeInfo(source: viewController, destination: detailVC)
        }
    }
    
    // MARK: Navigation
    
    func navigateToJokeInfo(source: JokesViewController, destination: JokeInfoViewController)
    {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToJokeInfo(source: JokesDataStore, destination: inout JokeInfoDataStore)
    {
        destination.jokeInfo = source.selectedJoke
    }
    
}
