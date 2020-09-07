//
//  MainCoordinator.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol {
    func start()
    func didSelect(productId: String)
    func didTouchCategories(action: ((CategoryType) -> Void)?)
}

class MainCoordinator: MainCoordinatorProtocol {
    var navigation: UINavigationController

    init(navigation: UINavigationController = UINavigationController()) {
        self.navigation = navigation
    }

    func start() {
        let navigationControler = MainBuilder().build(coodinator: self)
        navigation = navigationControler
    }

    func didSelect(productId: String) {
        let detailCoordinator = DetailCoordinator(productId: productId, navigation: navigation)
        detailCoordinator.start()
    }

    func didTouchCategories(action: ((CategoryType) -> Void)?) {
        let categoryCoordinator = CategoryCoordinator(navigation: navigation,
                                                      action: action)
        categoryCoordinator.start()
    }
}
