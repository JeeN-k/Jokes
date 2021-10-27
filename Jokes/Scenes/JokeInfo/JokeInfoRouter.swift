//
//  JokeInfoRouter.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol JokeInfoRoutingLogic {
    
}

protocol JokeInfoDataPassing {
    var dataStore: JokeInfoDataStore? { get }
}

class JokeInfoRouter: NSObject, JokeInfoRoutingLogic, JokeInfoDataPassing {
    var dataStore: JokeInfoDataStore?
    weak var viewController: JokeInfoViewController?
    
    // MARK: Routing
    
}
