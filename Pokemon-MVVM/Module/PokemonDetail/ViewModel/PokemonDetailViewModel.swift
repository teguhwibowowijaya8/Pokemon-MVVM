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
    private var getAPIService: GetAPIService
    var pokemonDetail: PokemonDetailModel?
    
    var delegate: PokemonDetailProtocol?
    
    init(url: String) {
        self.url = url
        getAPIService = GetAPIService()
    }
    
    func getDetail() {
        getAPIService.set(url: url)
        getAPIService.callGetAPI(model: PokemonDetailModel.self) { response in
            switch response {
            case .success(let pokemonDetail):
                self.pokemonDetail = pokemonDetail
                let group = DispatchGroup()
                let moves = pokemonDetail.moves
                
                for (index, move) in moves.enumerated() {
                    group.enter()
                    self.getMoveDetail(urlString: move.move.detailUrlString) { moveDetail in
                        self.pokemonDetail?.moves[index].move.moveDetail = moveDetail
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    self.delegate?.onPokemonDetailFetched(errorMessage: nil)
                    return
                }
                
                
            case .failure(let error):
                let errorMessage: String
                
                switch error {
                case .noData:
                    errorMessage = "No Data Available"
                case .invalidUrl:
                    errorMessage = "URL given is invalid"
                case .parseError:
                    errorMessage = "Parse JSON to Model is Failure"
                case .fetchError(let message):
                    errorMessage = message
                }
                
                self.delegate?.onPokemonDetailFetched(errorMessage: errorMessage)
                return
            }
        }
    }
    
    func getMoveDetail(
        urlString: String,
        completion: @escaping (MoveDetailModel?) -> Void
    ) {
        getAPIService.set(url: urlString)
        getAPIService.callGetAPI(model: MoveDetailModel.self) { response in
            switch response {
            case .success(let moveDetail):
                return completion(moveDetail)
                
            case .failure(let error):
                print(error)
                return completion(nil)
            }
        }
    }
}
