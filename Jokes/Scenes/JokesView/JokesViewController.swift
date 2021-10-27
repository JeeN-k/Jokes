//
//  ViewController.swift
//  Jokes
//
//  Created by Oleg Stepanov on 21.10.2021.
//

import UIKit

protocol JokesDisplayLogic: AnyObject {
    func displayJokes(viewModel: Jokelist.FetchJokes.ViewModel)
}

class JokesViewController: UIViewController, JokesDisplayLogic {
    
    var interactor: JokesBusinessLogic?
    var router: (NSObjectProtocol & JokesRoutingLogic & JokeDataPassing)?
    var selectedJoke: JokeItem?
    
    private var refreshControl: UIRefreshControl = {
        let refreshConrtol = UIRefreshControl()
        refreshConrtol.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshConrtol
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var jokesViewModel = JokeViewModel.init(cells: [])
    private var jokeItems = [JokeItem]()
    
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
        router.dataStore          = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            print(selector)
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        requestToFetchJokes()
    }
    
    func displayJokes(viewModel: Jokelist.FetchJokes.ViewModel) {
        jokesViewModel = viewModel.jokeViewModel
        jokeItems = viewModel.jokes
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func setupTable() {
        tableView.register(JokeCell.self, forCellReuseIdentifier: JokeCell.reuseID)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        view.backgroundColor = #colorLiteral(red: 0.6189912558, green: 0.6920314431, blue: 0.3463213444, alpha: 1)
        tableView.addSubview(refreshControl)
    }
    
    private func requestToFetchJokes() {
        let request = Jokelist.FetchJokes.Request()
        interactor?.getJokes(request: request)
    }
    
    private func requestToSelectJoke(index: Int) {
        let request = Jokelist.SelectJoke.Request(index: index)
        interactor?.selectJoke(requst: request)
    }
    
    @objc private func refresh() {
        requestToFetchJokes()
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
        requestToSelectJoke(index: indexPath.row)
        router?.routeToJokeInfo(segue: nil)
    }
}
