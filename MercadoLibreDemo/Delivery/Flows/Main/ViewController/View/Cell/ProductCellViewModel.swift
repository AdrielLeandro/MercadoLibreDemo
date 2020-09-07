//
//  ProductCellViewModel.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

class ProductCellViewModel {
    let title: String
    let imagePath: String
    let price: String
    let address: String

    init(title: String, price: String, address: String, imagePath: String) {
        self.title = title
        self.price = price
        self.address = address
        self.imagePath = imagePath
    }
}
