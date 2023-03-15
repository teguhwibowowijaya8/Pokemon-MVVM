//
//  GetAPIService.swift
//  Pokemon-MVVM
//
//  Created by Teguh Wibowo Wijaya on 15/03/23.
//

import Foundation

enum GetAPIServiceError: Error {
    case invalidUrl
    case fetchError(errorMessage: String)
    case parseError
    case noData
}

protocol GetAPIServiceProtocol {
    mutating func set(url: URL?)
    func callGetAPI<T: Decodable>(
        model: T.Type,
        onCompletion: @escaping (Result<T, GetAPIServiceError>) -> Void
    )
}

struct GetAPIService: GetAPIServiceProtocol {
    private var url: URL?
    private let fetchDataService: FetchDataService
    private let parseDataService: ParseDataService
    
    init() {
        parseDataService = ParseDataService()
        fetchDataService = FetchDataService()
    }
    
    mutating func set(url: URL?) {
        self.url = url
    }
    
    func callGetAPI<T>(
        model: T.Type,
        onCompletion: @escaping (Result<T, GetAPIServiceError>) -> Void)
    where T : Decodable {
        
        guard let url = url
        else { return onCompletion(.failure(.invalidUrl))}
        
        fetchDataService.fetch(url: url) { response in
            switch response {
            case .success(let data):
                if let modelData = parseDataService.parse(data: data, to: model) {
                    return onCompletion(.success(modelData))
                }
                return onCompletion(.failure(.parseError))
                
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
