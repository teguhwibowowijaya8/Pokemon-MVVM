//
//  GetImageService.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import UIKit

enum GetImageError: Error {
    case invalidUrl
    case fetchError(errorMessage: String)
    case noData
}

protocol GetImageProtocol {
    func getImage(
        from url: URL?,
        onCompletion: @escaping (Result<UIImage?, GetImageError>) -> Void
    )
}

struct GetImageService: GetImageProtocol {
    private let fetchDataService: FetchDataService
    
    init() {
        fetchDataService = FetchDataService()
    }
    
    func getImage(from url: URL?, onCompletion: @escaping (Result<UIImage?, GetImageError>) -> Void) {
        guard let url = url
        else { return onCompletion(.failure(.invalidUrl)) }
        
        fetchDataService.fetch(url: url) { response in
            switch response {
            case .success(let data):
                let image = UIImage(data: data)
                return onCompletion(.success(image))
                
            case .failure(let error):
                switch error {
                case .fetchError(let errorMessage):
                    return onCompletion(.failure(.fetchError(errorMessage: errorMessage)))
                    
                case .noData:
                    return onCompletion(.failure(.noData))
                }
            }
        }
    }
    
}
