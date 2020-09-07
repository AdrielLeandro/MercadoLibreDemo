//
//  MainCoordinatorMock.swift
//  MercadoLibreDemoTests
//
//  Created by Adriel on 9/5/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation
@testable import MercadoLibreDemo

class MainCoordinatorMock: MainCoordinatorProtocol {
    var invokeDidTouchCategory = false
    var invokeDidTouchProduct = false
    var categoriesClosure: (((CategoryType) -> Void)?) -> Void = { _ in }

    func start() {}

    func didSelect(productId: String) {
        invokeDidTouchProduct = true
    }

    func didTouchCategories(action: ((CategoryType) -> Void)?){
        categoriesClosure(action)
        invokeDidTouchCategory = true
    }
}
