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
        onCompletion: @escaping (PokemonsModel?, String?) -> Void
    )
}

class GetPokemonListService {
    private var getAPIService: GetAPIProtocol
    private var getPokemonListImageService: GetPokemonListImageService?
    private var pokemons: PokemonsModel?
    
    init(getAPIService: GetAPIProtocol = GetAPIService()) {
        self.getAPIService = getAPIService
        self.getPokemonListImageService = GetPokemonListImageService()
    }
    
    func getPokemonList(
        url: String,
        onCompletion: @escaping (PokemonsModel?, String?) -> Void
    ) {
        getAPIService.set(url: url)
        getAPIService.callGetAPI(model: PokemonsModel.self) { response in
            switch response {
            case .success(let pokemonsData):
                self.pokemons = pokemonsData
                let group = DispatchGroup()
                
                for (index, pokemon) in pokemonsData.result.enumerated() {
                    group.enter()
                    self.getPokemonListImageService?.getPokemonDetailImage(from: pokemon.url) { imageDetail in
                        self.pokemons?.result[index].image = imageDetail
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    return onCompletion(self.pokemons, nil)
                }
                
            case .failure(let error):
                return onCompletion(nil, error.localizedDescription)
            }
        }
    }
}
