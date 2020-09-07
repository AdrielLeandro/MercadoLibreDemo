//
//  DetailCoordinator.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/30/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

protocol DetailCoordinatorProtocol {
    func start()
    func close()
}

class DetailCoordinator: DetailCoordinatorProtocol {
    private let navigation: UINavigationController
    private let productId: String
    
    init(productId: String, navigation: UINavigationController) {
        self.navigation = navigation
        self.productId = productId
    }

    func start() {
        let viewController = DetailBuilder().builder(coordinator: self, productId: productId)
        navigation.pushViewController(viewController, animated: true)
    }

    func close() {
        navigation.dismiss(animated: true, completion: nil)
    }

}
