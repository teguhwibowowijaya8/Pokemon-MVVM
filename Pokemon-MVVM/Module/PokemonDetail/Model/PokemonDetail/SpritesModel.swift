//
//  SpritesModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation


struct SpritesModel: Decodable {
    let imageUrlString: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrlString = "front_default"
    }
}
