//
//  CategoryBuilder.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 9/1/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

class CategoryBuilder {
    func builder(coordinator: CategoryCoordinator) -> UIViewController {
        let viewModel = CategoryViewModel(networkRepository: NetworkRepository(),
                                          coordinator: coordinator)

        return CategoryViewController(viewModel: viewModel)
    }
}
