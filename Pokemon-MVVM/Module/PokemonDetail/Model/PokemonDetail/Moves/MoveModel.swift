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
    var moveDetail: MoveDetailModel?
    
    var detailUrl: URL? {
        return URL(string: detailUrlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case detailUrlString = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.detailUrlString = try container.decode(String.self, forKey: .detailUrlString)
    }
}
