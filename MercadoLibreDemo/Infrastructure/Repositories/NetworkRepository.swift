//
//  NetworkRepository.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation
import Moya

protocol NetworkRepositoryProtocol {
    func search(item: String, categoryId: String?, completion: @escaping (Result<[Product], Error>) -> Void)
    func product(id: String, completion: @escaping (Result<Product, Error>) -> Void)
    func categories(completion: @escaping (Result<[CategoryType], Error>) -> Void)
}

class NetworkRepository: NetworkRepositoryProtocol {
    let provider = MoyaProvider<MainApi>()

    func search(item: String, categoryId: String?, completion: @escaping (Result<[Product], Error>) -> Void) {
        var parameters: [String: Any] = [ConstantParams.search: item]
        if let categoryId = categoryId {
            parameters[ConstantParams.category] = categoryId
        }
        provider.request(.search(parameters: parameters)) { result in
            switch result {
            case.success(let response):
                guard let result = try? JSONDecoder().decode(ResultDTO.self, from: response.data) else {
                    completion(.failure(NSError(domain: "", code: 1, userInfo: nil)))
                    return
                }
                completion(.success(result.toProducts()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func product(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
        provider.request(.product(id: id)) { result in
            switch result {
            case .success(let response):
                guard let result = try? JSONDecoder().decode(ProductDTO.self, from: response.data) else {
                    completion(.failure(NSError(domain: "", code: 1, userInfo: nil)))
                    return
                }
                completion(.success(result.toProduct()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func categories(completion: @escaping (Result<[CategoryType], Error>) -> Void) {
        provider.request(.categories) { result in
            switch result {
            case .success(let response):
                guard let result = try? JSONDecoder().decode([CategoryDTO].self, from: response.data) else {
                    completion(.failure(NSError(domain: "", code: 1, userInfo: nil)))
                    return
                }
                completion(.success(result.map { $0.toCategory } ))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
