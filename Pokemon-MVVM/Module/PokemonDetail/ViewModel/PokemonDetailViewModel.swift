//
//  PokemonDetailViewModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import Foundation

struct PokemonDetailViewModel {
    private var url: String
    private let getAPIService: GetAPIService
    private var pokemonDetail: PokemonDetailModel?
    
    init(url: String) {
        self.url = url
        getAPIService = GetAPIService()
    }
    
    func getDetail() {
        
    }
}
