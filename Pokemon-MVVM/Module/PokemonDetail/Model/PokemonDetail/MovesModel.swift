//
//  MoveModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct MovesModel: Decodable {
    var move: MoveModel
    var hideDescription: Bool? = true
    
    mutating func toggleDescription() {
        self.hideDescription?.toggle()
    }
    
    enum CodingKeys: CodingKey {
        case move
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.move = try container.decode(MoveModel.self, forKey: .move)
    }
}
