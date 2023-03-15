//
//  FetchDataService.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

enum FetchDataServiceError: Error {
    case fetchError(errorMessage: String)
    case noData
}

protocol FetchDataServiceProtocol {
    func fetch(
        url: URL,
        onCompletion: @escaping (Result<Data, FetchDataServiceError>) -> Void
    )
}

struct FetchDataService: FetchDataServiceProtocol {
    func fetch(
        url: URL,
        onCompletion: @escaping (Result<Data, FetchDataServiceError>) -> Void
    ){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return onCompletion(.failure(.fetchError(errorMessage: error.localizedDescription)))
            } else if let response = response as? HTTPURLResponse, response.statusCode > 299 {
                return onCompletion(.failure(.fetchError(errorMessage: "Fetched Error with Status Code \(response.statusCode)")))
            }
            
            if let data = data {
                return onCompletion(.success(data))
            }
            
            return onCompletion(.failure(.noData))
        }
    }
}
