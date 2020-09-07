//
//  CategoryDTO.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 9/1/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

struct CategoryDTO {
    let id: String
    let name: String

    var toCategory: CategoryType {
        return CategoryType(id: id, name: name)
    }
}

extension CategoryDTO: Decodable {
    enum Key: String, CodingKey {
        case id, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
}
