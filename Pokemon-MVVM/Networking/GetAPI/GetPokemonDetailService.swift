//
//  GetPokemonMovesService.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 17/03/23.
//

import Foundation

protocol GetPokemonDetailProtocol {
    func getDetail(
        of urlString: String,
        onCompletion: @escaping (PokemonDetailModel?, String?) -> Void
    )
}

class GetPokemonDetailService: GetPokemonDetailProtocol {
    var getAPIService: GetAPIService
    var getMoveDetailService: GetPokemonMoveDetailService
    var pokemonDetail: PokemonDetailModel?
    
    init(getAPIService: GetAPIService = GetAPIService()) {
        self.getAPIService = getAPIService
        self.getMoveDetailService = GetPokemonMoveDetailService()
    }
    
    func getDetail(
        of urlString: String,
        onCompletion: @escaping (PokemonDetailModel?, String?) -> Void
    ) {
        self.pokemonDetail = nil
        getAPIService.set(url: urlString)
        getAPIService.callGetAPI(model: PokemonDetailModel.self) { response in
            switch response {
            case .success(let pokemonDetailData):
                self.pokemonDetail = pokemonDetailData
                
                let group = DispatchGroup()
                let moves = pokemonDetailData.moves
                
                for (index, move) in moves.enumerated() {
                    group.enter()
                    self.getMoveDetailService.getMoveDetail(urlString: move.move.detailUrlString) { moveDetail in
                        self.pokemonDetail?.moves[index].move.moveDetail = moveDetail
                        group.leave()
                    }
                }
                
                group.notify(queue: .main) {
                    return onCompletion(self.pokemonDetail, nil)
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
                
                return onCompletion(nil, errorMessage)
            }
        }
    }
}
