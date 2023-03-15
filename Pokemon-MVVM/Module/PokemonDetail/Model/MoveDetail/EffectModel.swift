//
//  EffectModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct EffectModel: Decodable {
    let effect: String
    let effectLanguage: [EffectLanguage]
    let shortEffect: String
    
    enum CodingKeys: String, CodingKey {
        case effect
        case effectLanguage = "language"
        case shortEffect = "short_effect"
    }
}
