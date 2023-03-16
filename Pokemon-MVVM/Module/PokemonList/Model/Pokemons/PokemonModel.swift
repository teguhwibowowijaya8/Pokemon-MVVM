//
//  PokemonModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct PokemonModel: Decodable {
    let name: String
    let url: String
    var image: PokemonDetailImageModel?
    
    var urlLink: URL? {
        return URL(string: url)
    }
    
    enum CodingKeys: CodingKey {
        case name
        case url
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        var name = try container.decode(String.self, forKey: .name)
        name.capitalizeFirstLetter()
        self.name = name
        
        self.url = try container.decode(String.self, forKey: .url)
    }
    
    mutating func setImage(with detailImageModel: PokemonDetailImageModel) {
        self.image = detailImageModel
    }
}
