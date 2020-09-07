//
//  DetailViewModel.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/30/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

class DetailViewModel {
    private let networkRepository: NetworkRepositoryProtocol
    private let coordinator: DetailCoordinatorProtocol
    private let productId: String
    var product: Product?
    var updateState: ((SearchState) -> Void)?

    init(networkRepository: NetworkRepositoryProtocol,
         coordinator: DetailCoordinatorProtocol,
         productId: String) {
        self.networkRepository = networkRepository
        self.coordinator = coordinator
        self.productId = productId
    }

    func getProductDetail() {
        updateState?(.loading)
        networkRepository.product(id: productId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let product):
                self.product = product
                self.updateState?(.success)
            case .failure:
                self.updateState?(.error)
            }
        }
    }
}
