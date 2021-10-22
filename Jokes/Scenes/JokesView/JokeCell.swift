//
//  JokeCell.swift
//  Jokes
//
//  Created by Oleg Stepanov on 21.10.2021.
//

import Foundation
import UIKit

protocol JokeCellViewModel {
    var category: String { get }
    var joke: String { get }
    var safebale: String { get }
}

class JokeCell: UITableViewCell {
    
    static let reuseID = "JokeCell"
    
    let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let jokeCategory: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let jokeStart: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 1
        return label
    }()
    
    let safable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        setupLayer()
    }
    
    func set(jokeModel: JokeCellViewModel) {
        jokeCategory.text = jokeModel.category
        jokeStart.text = jokeModel.joke
        safable.text = jokeModel.safebale
        
        if safable.text == "Safe" {
            safable.textColor = #colorLiteral(red: 0, green: 0.7239268422, blue: 0, alpha: 1)
        } else {
            safable.textColor = .red
        }
    }
    
    private func setupLayer() {
        addSubview(mainView)
        mainView.addSubview(jokeCategory)
        mainView.addSubview(jokeStart)
        mainView.addSubview(safable)
        
        mainView.layer.cornerRadius = 5
        mainView.clipsToBounds = true
        
        mainView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        mainView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        jokeCategory.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        jokeCategory.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8).isActive = true
        
        safable.centerYAnchor.constraint(equalTo: mainView.centerYAnchor).isActive = true
        safable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        jokeStart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        jokeStart.topAnchor.constraint(equalTo: jokeCategory.bottomAnchor, constant: 5).isActive = true
        jokeStart.widthAnchor.constraint(equalToConstant: frame.width - 40).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
