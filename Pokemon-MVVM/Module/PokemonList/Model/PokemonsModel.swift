//
//  PokemonListModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct Pokemon: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let result: [PokemonModel]
    
    var nextURL: URL? {
        guard let next = next else {return nil}
        return URL(string: next)
    }
    
    var previousURL: URL? {
        guard let previous = previous else {return nil}
        return URL(string: previous)
    }
}
