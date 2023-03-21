//
//  GetPokemonMoveDetailService.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 17/03/23.
//

import Foundation

protocol GetPokemonMoveDetailProtocol {
    mutating func getMoveDetail(
        urlString: String,
        completion: @escaping (MoveDetailModel?) -> Void
    )
}

struct GetPokemonMoveDetailService {
    private var getAPIService: GetAPIProtocol
    
    init(getAPIService: GetAPIProtocol = GetAPIService()) {
        self.getAPIService = getAPIService
    }
    
    mutating func getMoveDetail(
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
