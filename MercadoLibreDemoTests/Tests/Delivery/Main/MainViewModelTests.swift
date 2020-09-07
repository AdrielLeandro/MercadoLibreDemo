//
//  MainViewModelTests.swift
//  MercadoLibreDemoTests
//
//  Created by Adriel on 9/5/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import XCTest
@testable import MercadoLibreDemo

class MainViewModelTests: XCTestCase {
    let networkingRepository = NetworkRepositoryMock()
    let mainCoordinator = MainCoordinatorMock()
    let indexPath = IndexPath(row: 0, section: 0)
    var viewModel: MainViewModel!

    enum Constant {
        static let item: String = "carta"
    }

    override func setUp() {
        viewModel = MainViewModel(networkRepository: networkingRepository, coordinator: mainCoordinator)

        networkingRepository.searchClosure = { completion in
            completion(.success([ProductMock.product]))
        }
    }

    func testDidSearch() {
        viewModel.search(item: Constant.item)
        XCTAssertEqual(viewModel.getProducts().count, 1)
    }

    func testInfoForView() {
        viewModel.search(item: Constant.item)
        XCTAssertEqual(viewModel.numberOfRow, 1)
        XCTAssertNotNil(viewModel.cellForRow(at: indexPath))
    }

    func testDidTouchRestore() {
        viewModel.search(item: Constant.item)
        viewModel.didTouchCategories()
        mainCoordinator.categoriesClosure = { completion in }
        XCTAssertNil(self.viewModel.categorySelected)
        viewModel.didTouchRestore()
        XCTAssertNil(viewModel.categorySelected)
    }

    func testDidSelectProduct() {
        viewModel.search(item: Constant.item)
        XCTAssertEqual(mainCoordinator.invokeDidTouchProduct, false)
        viewModel.didSelect(indexPath: indexPath)
        XCTAssertEqual(mainCoordinator.invokeDidTouchProduct, true)
    }

    func testDidTouchButtonToGoCategoriesView() {
        viewModel.search(item: Constant.item)
        XCTAssertEqual(mainCoordinator.invokeDidTouchCategory, false)
        viewModel.didTouchCategories()
        XCTAssertEqual(mainCoordinator.invokeDidTouchCategory, true)
    }
}
