//
//  APIScheme.swift
//  Jokes
//
//  Created by Oleg Stepanov on 22.10.2021.
//

import Foundation


enum APIS{
    case joke
    case translate
    
    func getAPI() -> APIScheme {
        switch self {
        case .joke:
            return APIScheme(scheme: "https", host: "v2.jokeapi.dev", path: "/joke/Any")
        case .translate:
            return APIScheme(scheme: "https", host: "translate.api.cloud.yandex.net", path: "/translate/v2/translate")
        }
    }
}

struct APIScheme{
    var scheme: String
    var host: String
    var path: String
    static let yandexKey = "Api-Key AQVN3G6BTf_uSPB-b4hnozdRzvOTg_X_gYgvGCRf"

    init (scheme: String, host: String, path: String) {
        self.scheme = scheme
        self.host = host
        self.path = path
    }
}
