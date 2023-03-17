//
//  PokemonDetail.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct MoveDetailModel: Decodable {
    let accuracy: Int?
    let power: Int?
    let pp: Int?
    let effectEntries: [EffectModel]
    
    enum CodingKeys: String, CodingKey {
        case accuracy
        case power
        case pp
        case effectEntries = "effect_entries"
    }
    
    var effectString: String? {
        var effectEntriesEn: EffectModel?
        
        for entry in effectEntries {
            if entry.effectLanguage.name == "en" {
                effectEntriesEn = entry
                break
            }
        }
        
        if let effectEntriesEn = effectEntriesEn {
            let effectString = effectEntriesEn.effect != nil ? effectEntriesEn.effect : effectEntriesEn.shortEffect
            return effectString
        } else {
            return nil
        }
    }
}
