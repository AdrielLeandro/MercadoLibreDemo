//
//  MainViewModel.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

enum SearchState {
    case success
    case loading
    case empty
    case search
    case error
}

class MainViewModel {
    private let coordinator: MainCoordinatorProtocol
    private let networkRepository: NetworkRepositoryProtocol
    private var products: [Product] = []
    private var productCellViewModels: [ProductCellViewModel] = []
    private var searchText: String = ""
    var categorySelected: CategoryType?
    var didTouchCategory: (() -> Void)?
    var updateState: ((SearchState) -> Void)?
    var actionFromCategories: ((CategoryType) -> Void)?

    init(networkRepository: NetworkRepositoryProtocol,
         coordinator: MainCoordinatorProtocol) {
        self.networkRepository = networkRepository
        self.coordinator = coordinator
    }

    func search(item: String) {
        if item.isEmpty {
            productCellViewModels.removeAll()
            updateState?(.search)
            return
        }

        searchText = item
        updateState?(.loading)
        networkRepository.search(item: item, categoryId: categorySelected?.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let products):
                if products.isEmpty {
                    self.updateState?(.empty)
                } else {
                    self.products = products
                    self.setupCells(with: products)
                    self.updateState?(.success)
                }
            case .failure:
                self.updateState?(.error)
            }
        }
    }

    private func setupCells(with products: [Product]) {
        productCellViewModels = products.map { ProductCellViewModel(title: $0.title,
                                                                    price: $0.priceWithCurrency,
                                                                    address: $0.address,
                                                                    imagePath: $0.imagePath) }
    }

    func didSelect(indexPath: IndexPath) {
        coordinator.didSelect(productId: products[indexPath.row].id)
    }

    func didTouchCategories() {
        coordinator.didTouchCategories { [weak self] category in
            guard let self = self else { return }
            self.actionFromCategories?(category)
            self.categorySelected = category
            if !self.searchText.isEmpty {
                self.search(item: self.searchText)
            }
        }
    }

    func didTouchRestore() {
        categorySelected = nil
    }

    func getProducts() -> [Product] {
        return products
    }
}

extension MainViewModel {
    var numberOfRow: Int {
        return products.count
    }

    func cellForRow(at indexPath: IndexPath) -> ProductCellViewModel {
        return productCellViewModels[indexPath.row]
    }
}
