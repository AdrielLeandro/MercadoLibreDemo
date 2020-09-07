//
//  CategoryCoordinatorMock.swift
//  MercadoLibreDemoTests
//
//  Created by Adriel on 9/5/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation
@testable import MercadoLibreDemo

class CategoryCoordinatorMock: CategoryCoordinatorProtocol {
    var invokeStart = false
    var invokeDidTouchCategory = false
    let indexPath = IndexPath(row: 0, section: 0)

    func start() {
        invokeStart = true
    }

    func didTouch(category: CategoryType) {
        invokeDidTouchCategory = true
    }
}
