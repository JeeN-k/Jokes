//
//  JokeInfoViewController.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import Foundation
import UIKit

protocol JokeInfoDisplayLogic: AnyObject {
    func display(viewModel: JokeInfo.Model.ViewModel.ViewModelData)
}

class JokeInfoViewController: UIViewController, JokeInfoDisplayLogic {
    
    var jokeItem: JokeItem?
    var id: Int?
    var interactor: JokeInfoBusinessLogic?
    var router: (NSObjectProtocol & JokeInfoRoutingLogic)?
    
    
    
    private func setup() {
        let viewController        = self
        let interactor            = JokeInfoInteractor()
        let presenter             = JokeInfoPresenter()
        let router                = JokeInfoRouter()
        viewController.router     = router
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    let categoryJoke: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let jokeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let setupJoke: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let deliveryJoke: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let safebleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLabelConstraints()
    }
    
    func display(viewModel: JokeInfo.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayJoke(let jokeItem):
            self.jokeItem = jokeItem
            setupLabels()
        }
    }
    
    private func setupLabels() {
        guard let jokeItem = jokeItem else { return }
        categoryJoke.text = jokeItem.category
        let safeble = jokeItem.safe
        if let joke = jokeItem.joke {
            jokeLabel.isHidden = false
            setupJoke.isHidden = true
            deliveryJoke.isHidden = true
            jokeLabel.text = joke
        } else {
            jokeLabel.isHidden = true
            setupJoke.isHidden = false
            deliveryJoke.isHidden = false
            setupJoke.text = jokeItem.setup
            deliveryJoke.text = jokeItem.delivery
        }
        
        if safeble {
            safebleLabel.text = "Safe"
        } else {
            safebleLabel.text = "Not safe"
        }
    }
    
    private func setupLabelConstraints() {
        view.addSubview(categoryJoke)
        view.addSubview(jokeLabel)
        view.addSubview(setupJoke)
        view.addSubview(deliveryJoke)
        view.addSubview(safebleLabel)
        
        categoryJoke.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        categoryJoke.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        jokeLabel.topAnchor.constraint(equalTo: categoryJoke.bottomAnchor, constant: 20).isActive = true
        jokeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        jokeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        setupJoke.topAnchor.constraint(equalTo: categoryJoke.bottomAnchor, constant: 20).isActive = true
        setupJoke.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        setupJoke.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        
        deliveryJoke.topAnchor.constraint(equalTo: setupJoke.bottomAnchor, constant: 10).isActive = true
        deliveryJoke.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        deliveryJoke.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
}
