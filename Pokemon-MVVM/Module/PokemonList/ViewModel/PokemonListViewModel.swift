//
//  PokemonListViewModel.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 16/03/23.
//

import UIKit

protocol PokemonListViewModelDelegate {
    func onPokemonListFetched()
    func showLoadingIndicator()
    func hideErrorView()
}

class PokemonListViewModel {
    private(set) var pokemons: PokemonsModel?
    private(set) var isLoading = false
    var errorMessage: String?
    private(set) var currentCount: Int = 0
    private(set) var isEndReach = false
    let limitFetch = 10
    private(set) var fetchTimes = 0

    private var getPokemonListService: GetPokemonListService
    private var getPokemonListImageService: GetPokemonListImageService
    private var baseUrlString = "https://pokeapi.co/api/v2/pokemon"
    
    var delegate: PokemonListViewModelDelegate?
    
    init() {
        getPokemonListService = GetPokemonListService()
        getPokemonListImageService = GetPokemonListImageService()
    }
    
    func getPokemonsUrl() -> String? {
        var url = URLComponents(string: baseUrlString)
        url?.queryItems = [
            URLQueryItem(name: "limit", value: "\(limitFetch)"),
            URLQueryItem(name: "offset", value: "\(fetchTimes * limitFetch)")
        ]
        
        return url?.string
    }
    
    func getPokemonList(
        reloadLoader: Bool = true,
        reloadError: Bool = false
    ) {
        guard isLoading == false,
              isEndReach == false,
              let urlString = getPokemonsUrl()
        else { return }

        isLoading = true
        if reloadLoader { showLoadingIndicator() }
        errorMessage = nil
        if reloadError { hideErrorView() }
        
        getPokemonListService.getPokemonList(url: urlString) { pokemonsData, error in
            if let pokemonsData = pokemonsData {
                self.fetchTimes += 1
                self.appendPokemons(with: pokemonsData)
                self.delegate?.onPokemonListFetched()
            } else if let error = error {
                self.errorMessage = error
                self.delegate?.onPokemonListFetched()
            }
            self.isLoading = false
        }
    }
    
    func showLoadingIndicator() {
        delegate?.showLoadingIndicator()
    }
    
    func hideErrorView() {
        delegate?.hideErrorView()
    }
    
    func appendPokemons(with pokemonsData: PokemonsModel) {
        if self.pokemons == nil {
            self.pokemons = pokemonsData
        } else {
            self.pokemons?.result.append(contentsOf: pokemonsData.result)
            self.pokemons?.next = pokemonsData.next
            self.pokemons?.previous = pokemonsData.previous
        }
        
        if let pokemons = self.pokemons {
            if pokemons.result.count >= pokemons.count
                { isEndReach = true }
            self.currentCount = pokemons.result.count - 1
        }
    }
}
