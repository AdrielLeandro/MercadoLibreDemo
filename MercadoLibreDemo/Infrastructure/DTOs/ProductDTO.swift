//
//  ProductDTO.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

struct ProductDTO {
    let id: String
    let title: String?
    let price: Double?
    let thumbnail: String?
    let sellerAddresss: SellerAddressDTO
    let warranty: String?
    let permalink: String?
    let availableQuantity: Int?
    let soldQuantity: Int?
    let acceptsMercadopago: Bool
    let pictures: [PictureDTO]?

    func toProduct() -> Product {
        return Product(id: id,
                       title: title ?? "",
                       price: price ?? 0,
                       imagePath: thumbnail ?? "",
                       country: sellerAddresss.toCountry,
                       city: sellerAddresss.toCity,
                       state: sellerAddresss.toState,
                       warranty: warranty ?? "",
                       permalink: permalink ?? "",
                       availableQuantity: availableQuantity ?? 0,
                       soldQuantity: soldQuantity ?? 0,
                       acceptsMercadopago: acceptsMercadopago, pictures: pictures?.compactMap { $0.toPicture } ?? [])
    }
}

extension ProductDTO: Decodable {
    enum Key: String, CodingKey {
        case id
        case title
        case price
        case thumbnail
        case sellerAddress = "seller_address"
        case warranty
        case permalink
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case acceptsMercadopago = "accepts_mercadopago"
        case pictures
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.price = try container.decode(Double.self, forKey: .price)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.sellerAddresss = try container.decode(SellerAddressDTO.self, forKey: .sellerAddress)
        self.warranty = try container.decodeIfPresent(String.self, forKey: .warranty)
        self.permalink = try container.decode(String.self, forKey: .permalink)
        self.availableQuantity = try container.decode(Int.self, forKey: .availableQuantity)
        self.soldQuantity = try container.decode(Int.self, forKey: .soldQuantity)
        self.acceptsMercadopago = try container.decode(Bool.self, forKey: .acceptsMercadopago)
        self.pictures = try? container.decodeIfPresent([PictureDTO].self, forKey: .pictures)
    }
}
