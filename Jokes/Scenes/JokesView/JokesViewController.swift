//
//  ViewController.swift
//  Jokes
//
//  Created by Oleg Stepanov on 21.10.2021.
//

import UIKit

protocol JokesDisplayLogic: AnyObject {
    func display(viewModel: Jokelist.Model.ViewModel.ViewModelData)
}

class JokesViewController: UIViewController, JokesDisplayLogic {
    
    var interactor: JokesBusinessLogic?
    var router: (NSObjectProtocol & JokesRoutingLogic)?
    var touchedJoke: JokeItem?
    
    
    @IBOutlet weak var tableView: UITableView!
    
    private var jokesViewModel = JokeViewModel.init(cells: [])
    
    private func setup() {
        let viewController        = self
        let interactor            = JokesInteractor()
        let presenter             = JokePresenter()
        let router                = JokeRouter()
        viewController.router     = router
        viewController.interactor = interactor
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        tableView.register(JokeCell.self, forCellReuseIdentifier: JokeCell.reuseID)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.backgroundColor = #colorLiteral(red: 0.6189912558, green: 0.6920314431, blue: 0.3463213444, alpha: 1)
        
        interactor?.makeRequest(request: .getJokes)
    }
    
    func display(viewModel: Jokelist.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayJokes(let jokesViewModel):
            self.jokesViewModel = jokesViewModel
            tableView.reloadData()
        }
    }
}

extension JokesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeCell.reuseID, for: indexPath) as! JokeCell
        let cellViewModel = jokesViewModel.cells[indexPath.row]
        cell.set(jokeModel: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = JokeInfoViewController(nibName: "JokeInfoViewController", bundle: nil)
        vc.id = jokesViewModel.cells[indexPath.row].id
        
        performSegue(withIdentifier: "showJoke", sender: nil)
    }
}
