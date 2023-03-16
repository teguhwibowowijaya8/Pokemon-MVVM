//
//  PokemonDetailModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct PokemonDetailModel: Decodable {
    let id: Int
    let name: String
    let sprites: SpritesModel
    var moves: [MovesModel]
    let stats: [StatsModel]
    
    var health: Int {
        for stat in stats {
            if stat.stat.name == "hp" {
                return stat.baseStat
            }
        }
        
        return 0
    }
}
