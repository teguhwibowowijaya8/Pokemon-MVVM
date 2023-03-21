//
//  GetPokemonListImageService.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import Foundation

protocol GetPokemonListImageProtocol {
    mutating func getPokemonDetailImage(
        from url: String,
        onCompletion: @escaping (PokemonDetailImageModel?) -> Void
    )
}

struct GetPokemonListImageService: GetPokemonListImageProtocol {
    private var getAPIService: GetAPIProtocol
    
    init(getAPIService: GetAPIProtocol = GetAPIService()) {
        self.getAPIService = getAPIService
    }
    
    mutating func getPokemonDetailImage(
        from url: String,
        onCompletion: @escaping (PokemonDetailImageModel?) -> Void
    ) {
        getAPIService.set(url: url)
        getAPIService.callGetAPI(model: PokemonDetailImageModel.self) { response in
            switch response {
            case .success(let detailImage):
                return onCompletion(detailImage)
                
            case .failure(let error):
                print(error)
                return onCompletion(nil)
            }
        }
    }
}
