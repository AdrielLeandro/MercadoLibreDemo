//
//  MainBuilder.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

class MainBuilder {
    func build(coodinator: MainCoordinator) -> UINavigationController {
        let viewModel = MainViewModel(networkRepository: NetworkRepository(),
                                      coordinator: coodinator)
        let navigationController = UINavigationController(rootViewController: MainViewController(viewModel: viewModel))
        return navigationController
    }
}
