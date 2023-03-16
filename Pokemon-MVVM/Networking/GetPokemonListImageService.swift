//
//  GetPokemonListImageService.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import Foundation

struct GetPokemonListImageService {
    private var getAPIService: GetAPIService
    
    init() {
        self.getAPIService = GetAPIService()
    }
    
    mutating func getPokemonDetailImage(
        from url: String,
        onCompletion: @escaping (Result<PokemonDetailImageModel, GetAPIError>) -> Void
    ) {
        getAPIService.set(url: url)
        getAPIService.callGetAPI(model: PokemonDetailImageModel.self) { response in
            switch response {
            case .success(let detailImage):
                return onCompletion(.success(detailImage))
                
            case .failure(let error):
                return onCompletion(.failure(error))
            }
        }
    }
}
