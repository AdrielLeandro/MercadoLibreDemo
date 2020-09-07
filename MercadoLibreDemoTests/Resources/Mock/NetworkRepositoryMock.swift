//
//  NetworkRepositoryMock.swift
//  MercadoLibreDemoTests
//
//  Created by Adriel on 9/5/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation
@testable import MercadoLibreDemo

class NetworkRepositoryMock: NetworkRepositoryProtocol {
    var searchClosure :((Result<[Product], Error>) -> Void) -> Void = { _ in }
    var productClosure: ((Result<Product, Error>) -> Void) -> Void = { _ in }
    var categoriesClosure: ((Result<[CategoryType], Error>) -> Void) -> Void = { _ in }

    func search(item: String, categoryId: String?, completion: @escaping (Result<[Product], Error>) -> Void) {
        searchClosure(completion)
    }

    func product(id: String, completion: @escaping (Result<Product, Error>) -> Void) {
        productClosure(completion)
    }

    func categories(completion: @escaping (Result<[CategoryType], Error>) -> Void) {
        categoriesClosure(completion)
    }
}
