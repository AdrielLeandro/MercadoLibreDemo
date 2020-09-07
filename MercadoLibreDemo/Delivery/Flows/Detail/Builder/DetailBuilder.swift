//
//  DetailBuilder.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/30/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

class DetailBuilder {
    func builder(coordinator: DetailCoordinatorProtocol, productId: String) -> UIViewController {
        let viewModel = DetailViewModel(networkRepository: NetworkRepository(), coordinator: coordinator, productId: productId)
        return DetailViewController(viewModel: viewModel)
    }
}
