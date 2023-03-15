//
//  PokemonDetail.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct MoveDetailModel: Decodable {
    let acuracy: Int
    let power: Int
    let pp: Int
    let effectEntries: [EffectModel]
    
    enum CodingKeys: String, CodingKey {
        case acuracy
        case power
        case pp
        case effectEntries = "effect_entries"
    }
}
