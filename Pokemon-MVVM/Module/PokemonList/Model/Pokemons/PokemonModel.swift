//
//  PokemonModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct PokemonModel: Decodable {
    let name: String
    let url: String
    
    var urlLink: URL? {
        return URL(string: url)
    }
}
