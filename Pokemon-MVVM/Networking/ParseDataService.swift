//
//  ParseDataService.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

protocol ParseDataServiceProtocol {
    func parse<T: Decodable>(data: Data, to model: T.Type) -> T?
}

struct ParseDataService: ParseDataServiceProtocol {
    func parse<T>(data: Data, to model: T.Type) -> T? where T : Decodable {
        do {
            let decoder = JSONDecoder()
            let parsedData = try decoder.decode(model, from: data)
            return parsedData
        } catch _ {
            return nil
        }
    }
}
