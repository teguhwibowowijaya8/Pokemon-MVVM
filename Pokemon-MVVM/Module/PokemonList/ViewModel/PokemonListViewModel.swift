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
    var pokemons: PokemonsModel?
    var isLoading = false
    var errorMessage: String?
    var currentCount: Int
    
    private var getPokemonListService: GetPokemonListService
    private var getPokemonListImageService: GetPokemonListImageService
    private var baseUrlString = "https://pokeapi.co/api/v2/pokemon?limit=30"
    
    var delegate: PokemonListViewModelDelegate?
    
    init() {
        getPokemonListService = GetPokemonListService()
        getPokemonListImageService = GetPokemonListImageService()
        currentCount = 0
    }
    
    func getPokemonList() {
        guard isLoading == false,
            let urlString = pokemons == nil ? baseUrlString : pokemons?.next
        else { return }
        isLoading = true
        errorMessage = nil
        getPokemonListService.getPokemonList(url: urlString) { pokemonsData, error in
            if let pokemonsData = pokemonsData {
                self.appendPokemons(with: pokemonsData)
                self.delegate?.onPokemonListFetched(errorMessage: nil)
            } else if let error = error {
                self.errorMessage = error
                self.delegate?.onPokemonListFetched(errorMessage: error)
            }
            self.isLoading = false
        }
    }
    
    func appendPokemons(with pokemonsData: PokemonsModel) {
        if self.pokemons == nil {
            self.pokemons = pokemonsData
        } else {
            self.pokemons?.result.append(contentsOf: pokemonsData.result)
            self.pokemons?.next = pokemonsData.next
            self.pokemons?.previous = pokemonsData.previous
        }
        
        if let count = self.pokemons?.result.count {
            self.currentCount = count - 1
        }
    }
}
