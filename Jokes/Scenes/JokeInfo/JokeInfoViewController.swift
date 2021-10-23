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
    
    let tranlsateButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(translateTouch), for: .touchUpInside)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    
    var interactor: JokeInfoBusinessLogic?
    var router: (NSObjectProtocol & JokeInfoRoutingLogic)?
    var translatedJoke: [String]?
    var translated = false
    
    var jokeItem: JokeItem?
    var id: Int?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        setupLabels()
        setupLabelConstraints()
    }
    
    @objc func translateTouch() {
        switchLanguage()
    }
    
    private func switchLanguage() {
        if !translated && translatedJoke == nil {
            let texts = setupTextToTranslate()
            guard let texts = texts else { return }
            interactor?.makeRequest(request: .translateText(texts: texts))
        } else if translated {
            setupLabels()
        } else if !translated {
            guard let translatedJoke = translatedJoke else { return }
            translateText(from: translatedJoke)
        }
        translated = !translated
    }
    
    private func setupTextToTranslate() -> [String]? {
        guard let category = categoryJoke.text else { return nil }
        if let joke = jokeLabel.text {
            return [category, joke]
        }
        if let setup = setupJoke.text, let delivery = deliveryJoke.text {
            return [category, setup, delivery]
        }
        return nil
    }
    
    private func translateText(from translationStrings: [String]) {
        translatedJoke = translationStrings
        categoryJoke.text = translationStrings.first
        if translationStrings.count == 3 {
            setupJoke.text = translationStrings[1]
            deliveryJoke.text = translationStrings[2]
        } else {
            jokeLabel.text = translationStrings[1]
        }
        tranlsateButton.setTitle("Оригинал", for: .normal)
    }
    
    func display(viewModel: JokeInfo.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .dispalyTranslation(let translation):
            let translationStrings = translation.map { $0.text }
            translateText(from: translationStrings)
        }
    }
    
    
}

// MARK: Work with objects
extension JokeInfoViewController {
    
    private func setupLabelConstraints() {
        view.addSubview(categoryJoke)
        view.addSubview(jokeLabel)
        view.addSubview(setupJoke)
        view.addSubview(deliveryJoke)
        view.addSubview(tranlsateButton)
        
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
        
        tranlsateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tranlsateButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupLabels() {
        guard let jokeItem = jokeItem else { return }
        categoryJoke.text = jokeItem.category
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
        tranlsateButton.setTitle("Перевести", for: .normal)
    }
}
