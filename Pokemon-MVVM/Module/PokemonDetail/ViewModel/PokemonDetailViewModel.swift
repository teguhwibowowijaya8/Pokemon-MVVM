//
//  PokemonDetailViewModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import Foundation

protocol PokemonDetailProtocol {
    func onPokemonDetailFetched(errorMessage: String?)
}

class PokemonDetailViewModel {
    private var url: String
    private var getPokemonDetailService: GetPokemonDetailService?
    var pokemonDetail: PokemonDetailModel?
    
    var delegate: PokemonDetailProtocol?
    
    init(url: String) {
        self.url = url
        getPokemonDetailService = GetPokemonDetailService()
    }
    
    func getDetail() {
        getPokemonDetailService?.getDetail(of: url) { pokemonDetailData, errorMessage in

            if let pokemonDetailData = pokemonDetailData {
                self.pokemonDetail = pokemonDetailData
                self.delegate?.onPokemonDetailFetched(errorMessage: nil)
                return
                
            } else if let errorMessage = errorMessage {
                self.delegate?.onPokemonDetailFetched(errorMessage: errorMessage)
                return
            }
            
        }
    }
}
