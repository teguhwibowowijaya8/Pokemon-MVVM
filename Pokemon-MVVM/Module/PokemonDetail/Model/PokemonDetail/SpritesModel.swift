//
//  SpritesModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation


struct SpritesModel: Decodable {
    let imageUrlString: String?
    
    var imageUrl: URL? {
        guard let image = imageUrlString else { return nil }
        return URL(string: image)
    }
    
    enum CodingKeys: String, CodingKey {
        case imageUrlString = "front_default"
    }
}
