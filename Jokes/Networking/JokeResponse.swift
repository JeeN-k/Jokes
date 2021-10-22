//
//  JokeResponse.swift
//  Jokes
//
//  Created by Oleg Stepanov on 21.10.2021.
//

import Foundation

struct JokeResponse: Decodable {
    var jokes: [JokeItem]
}

struct JokeItem: Decodable {
    var category: String
    var type: String
    var joke: String?
    var setup: String?
    var delivery: String?
    var id: Int
    var safe: Bool
}
