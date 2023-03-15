//
//  StatsModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct StatsModel: Decodable {
    let baseStat: Int
    let stat: StatModel
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}
