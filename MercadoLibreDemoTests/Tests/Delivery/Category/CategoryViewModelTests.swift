//
//  CategoryViewModelTests.swift
//  MercadoLibreDemoTests
//
//  Created by Adriel on 9/5/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import XCTest
@testable import MercadoLibreDemo

class CategoryViewModelTests: XCTestCase {
    let networkingRepository = NetworkRepositoryMock()
    let categoryCoordinator = CategoryCoordinatorMock()
    var viewModel: CategoryViewModel!
    let indexPath = IndexPath(row: 0, section: 0)
    override func setUp() {
        viewModel = CategoryViewModel(networkRepository: networkingRepository,
                                      coordinator: categoryCoordinator)
        networkingRepository.categoriesClosure = { completion in
            completion(.success([CategoryTypeMock.categoryType]))
        }
    }

    func testDidSelectCategory() {
        viewModel.getCategories()
        XCTAssertEqual(categoryCoordinator.invokeDidTouchCategory, false)
        viewModel.didSelectRow(at: indexPath)
        XCTAssertEqual(categoryCoordinator.invokeDidTouchCategory, true)
    }

    func testInfoForView() {
        viewModel.getCategories()
        XCTAssertEqual(viewModel.numberOfRow, 1)
        XCTAssertNotNil(viewModel.cellForRow(at: indexPath))
    }
}
