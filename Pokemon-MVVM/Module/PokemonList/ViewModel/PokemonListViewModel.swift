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
        getPokemonListService.getPokemonList(url: urlString) { response in
            switch response {
            case .success(let pokemons):
                self.pokemons = pokemons
                self.delegate?.onPokemonListFetched(errorMessage: nil)
                
            case .failure(let error):
                let errorMessage: String
                switch error {
                case .parseError:
                    errorMessage = "Parse Error"
                case .invalidUrl:
                    errorMessage = "Invalid URL"
                case .fetchError(let fetchError):
                    errorMessage = fetchError
                case .noData:
                    errorMessage = "No Data"
                }
                
                self.delegate?.onPokemonListFetched(errorMessage: errorMessage)
            }
        }
    }
    
    func getPokemonDetailImage(
        of detailUrl: String,
        onCompletion: @escaping (String?) -> Void
    ) {
        getPokemonListImageService.getPokemonDetailImage(from: detailUrl) { response in
            switch response {
            case .success(let image):
                onCompletion(image.sprites.imageUrlString)
                
            case .failure(let error):
                print(error)
                onCompletion(nil)
            }
        }
    }
    
}
