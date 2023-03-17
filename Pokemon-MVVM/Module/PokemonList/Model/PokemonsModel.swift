//
//  PokemonListModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct PokemonsModel: Decodable {
    let count: Int
    var next: String?
    var previous: String?
    var result: [PokemonModel]
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case result = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.next = try container.decodeIfPresent(String.self, forKey: .next)
        self.previous = try container.decodeIfPresent(String.self, forKey: .previous)
        self.result = try container.decode([PokemonModel].self, forKey: .result)
    }
}
