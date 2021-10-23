//
//  TranslateResponse.swift
//  Jokes
//
//  Created by Oleg Stepanov on 23.10.2021.
//

import Foundation


struct TranslateResponse: Decodable {
    var translations: [Translation]
}

struct Translation: Decodable {
    var text: String
}
