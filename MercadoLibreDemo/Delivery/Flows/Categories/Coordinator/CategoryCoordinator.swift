//
//  CategoryCoordinator.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 9/1/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

protocol CategoryCoordinatorProtocol {
    func start()
    func didTouch(category: CategoryType)
}

class CategoryCoordinator: CategoryCoordinatorProtocol {
    private let navigation: UINavigationController
    private let action: ((CategoryType) -> Void)?

    init(navigation: UINavigationController, action: ((CategoryType) -> Void)?) {
        self.navigation = navigation
        self.action = action
    }

    func start() {
        let viewController = CategoryBuilder().builder(coordinator: self)
        navigation.pushViewController(viewController, animated: true)
    }

    func didTouch(category: CategoryType) {
        action?(category)
        navigation.popViewController(animated: true)
    }
}
