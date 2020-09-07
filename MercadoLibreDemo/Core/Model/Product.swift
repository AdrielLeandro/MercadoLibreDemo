//
//  Product.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

struct Product {
    let id: String
    let title: String
    let price: Double
    let imagePath: String
    let country: Country
    let city: City
    let state: State
    let warranty: String
    let permalink: String
    let availableQuantity: Int
    let soldQuantity: Int
    let acceptsMercadopago: Bool
    let pictures: [Picture]

    var stockAvailable: Bool {
        return availableQuantity > 0
    }
    
    var priceWithCurrency: String {
        return "$\(price)"
    }

    var address: String {
        var address = ""
        if !city.name.isEmpty {
            address += city.name.lowercased().capitalizingFirstLetter()
        }
        if !state.name.isEmpty {
            address += ", \(state.name.lowercased().capitalizingFirstLetter())"
        }

        if !country.name.isEmpty {
            address += ", \(country.name.lowercased().capitalizingFirstLetter())"
        }

        return address
    }
}
