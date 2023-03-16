//
//  GetPokemonListService.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import Foundation

protocol GetPokemonListProtocol {
    mutating func getPokemonList(
        url: String,
        onCompletion: @escaping (Result<Pokemons, GetAPIError>) -> Void
    )
}

struct GetPokemonListService {
    private var getAPIService: GetAPIService
    private var getPokemonListImageService: GetPokemonListImageService
    
    init() {
        self.getAPIService = GetAPIService()
        self.getPokemonListImageService = GetPokemonListImageService()
    }
    
    mutating func getPokemonList(
        url: String,
        onCompletion: @escaping (Result<Pokemons, GetAPIError>) -> Void
    ) {
        getAPIService.set(url: url)
        getAPIService.callGetAPI(model: Pokemons.self) { response in
            switch response {
            case .success(let pokemons):
                return onCompletion(.success(pokemons))
                
            case .failure(let error):
                return onCompletion(.failure(error))
            }
        }
    }
}
