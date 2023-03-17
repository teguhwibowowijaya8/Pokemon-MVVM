//
//  PokemonListViewModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import UIKit

protocol PokemonListViewModelDelegate {
    func onPokemonListFetched(errorMessage: String?)
}

class PokemonListViewModel {
    var pokemons: Pokemons?
    
    private var getPokemonListService: GetPokemonListService
    private var getPokemonListImageService: GetPokemonListImageService
    private let urlString = "https://pokeapi.co/api/v2/pokemon?limit=100"
    
    var delegate: PokemonListViewModelDelegate?
    
    init() {
        self.getPokemonListService = GetPokemonListService()
        self.getPokemonListImageService = GetPokemonListImageService()
    }
    
    func getPokemonList() {
        getPokemonListService.getPokemonList(url: urlString) { pokemonsData, errorMessage in
            if let pokemonsData = pokemonsData {
                self.pokemons = pokemonsData
                self.delegate?.onPokemonListFetched(errorMessage: nil)
            } else {
                self.delegate?.onPokemonListFetched(errorMessage: errorMessage)
            }
        }
    }
}
