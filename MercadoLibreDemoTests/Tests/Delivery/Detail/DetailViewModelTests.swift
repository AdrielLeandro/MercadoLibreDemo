//
//  DetailViewModelTests.swift
//  MercadoLibreDemoTests
//
//  Created by Adriel on 9/5/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import XCTest
@testable import MercadoLibreDemo

class DetailViewModelTests: XCTestCase {
    let networkingRepository = NetworkRepositoryMock()
    let detailCoordinator = DetailCoordinatorMock()
    var viewModel: DetailViewModel!

    override func setUp() {
        viewModel = DetailViewModel(networkRepository: networkingRepository,
                                    coordinator: detailCoordinator,
                                    productId: "MLA843854044")
        networkingRepository.productClosure = { completion in
            completion(.success(ProductMock.product))
        }
    }


    func testInfoForView() {
        XCTAssertNil(viewModel.product)
        viewModel.getProductDetail()
        XCTAssertNotNil(viewModel.product)
    }
}
