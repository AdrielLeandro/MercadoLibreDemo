//
//  DetailCoordinatorMock.swift
//  MercadoLibreDemoTests
//
//  Created by Adriel on 9/5/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation
@testable import MercadoLibreDemo

class DetailCoordinatorMock: DetailCoordinatorProtocol {
    var invokeClose = false
    var invokeStart = false

    func start() {
        invokeStart = true
    }

    func close() {
        invokeClose = true
    }
}
