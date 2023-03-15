//
//  MoveModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

struct MoveModel: Decodable {
    let name: String
    let detailUrlString: String
    
    var detailUrl: URL? {
        return URL(string: detailUrlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case detailUrlString = "url"
    }
}
