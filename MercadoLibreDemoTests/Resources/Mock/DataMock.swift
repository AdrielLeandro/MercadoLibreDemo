//
//  DataMock.swift
//  MercadoLibreDemoTests
//
//  Created by Adriel on 9/5/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation
@testable import MercadoLibreDemo

struct ProductMock {
    static let product = Product(id: "MLA843854044",
                                 title: "Cartas Dragon Ball Z Super Promocion",
                                 price: 399,
                                 imagePath: "http://http2.mlstatic.com/D_646603-MLA41120397357_032020-I.jpg",
                                 country: CountryMock.country,
                                 city: CityMock.city,
                                 state: StateMock.state,
                                 warranty: "Garantía de fábrica: 30 días",
                                 permalink: "https://articulo.mercadolibre.com.ar/MLA-843854044-cartas-dragon-ball-z-super-promocion-cuarentena-40-s-2-maz-_JM",
                                 availableQuantity: 50,
                                 soldQuantity: 5,
                                 acceptsMercadopago: false,
                                 pictures: [PictureMock.firstPicture])
}

struct CountryMock {
    static let country = Country(id: "AR", name: "Argentina")
}

struct StateMock {
    static let state = State(id: "AR-C", name: "Capital Federal")
}

struct CityMock {
    static let city = City(id: "", name: "Versalles")
}

struct PictureMock {
    static let firstPicture = Picture(id: "646603-MLA41120397357_032020", url: "http://http2.mlstatic.com/D_751398-MLA41120379759_032020-O.jpg")
}

struct CategoryTypeMock {
    static let categoryType = CategoryType(id: "MLA5725", name: "Accesorios para Vehículos")
}
