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
    let moves: [MovesModel]
    let stat: [StatsModel]
}
