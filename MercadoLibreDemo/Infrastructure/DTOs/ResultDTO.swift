//
//  ResultDTO.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

struct ResultDTO {
    let results: [ProductDTO]

    func toProducts() -> [Product] {
        return results.map { $0.toProduct() }
    }
}

extension ResultDTO: Decodable {
    enum Key: String, CodingKey {
      case results
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.results = try container.decode([ProductDTO].self, forKey: .results)
    }
}
