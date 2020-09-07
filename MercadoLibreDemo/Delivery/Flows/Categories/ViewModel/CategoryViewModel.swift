//
//  CategoryViewModel.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 9/1/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

class CategoryViewModel {
    private let networkRepository: NetworkRepositoryProtocol
    private let coordinator: CategoryCoordinatorProtocol
    private var categories: [CategoryType] = []
    private var categoryCellViewModel: [CategoryCellViewModel] = []
    var updateState: ((SearchState) -> Void)?

    init(networkRepository: NetworkRepositoryProtocol,
         coordinator: CategoryCoordinatorProtocol) {
        self.networkRepository = networkRepository
        self.coordinator = coordinator
    }

    func getCategories() {
        updateState?(.loading)
        networkRepository.categories { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let categories):
                self.categories = categories
                self.setupCells(with: categories)
                self.updateState?(.success)
            case .failure:
                self.updateState?(.error)
            }
        }
    }

    private func setupCells(with categories: [CategoryType]) {
        categoryCellViewModel = categories.map { CategoryCellViewModel(name: $0.name) }
    }

    func didSelectRow(at indexPath: IndexPath) {
        coordinator.didTouch(category: categories[indexPath.row])
    }

}

extension CategoryViewModel {
    var numberOfRow: Int {
        return categoryCellViewModel.count
    }

    func cellForRow(at indexPath: IndexPath) -> CategoryCellViewModel {
        return categoryCellViewModel[indexPath.row]
    }
}
