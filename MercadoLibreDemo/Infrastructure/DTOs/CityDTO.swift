//
//  CityDTO.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/30/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

struct CityDTO {
    let id: String?
    let name: String?
}

extension CityDTO: Decodable {
    enum Key: String, CodingKey {
        case id, name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.id = try? container.decodeIfPresent(String.self, forKey: .id)
        self.name = try? container.decodeIfPresent(String.self, forKey: .name)
    }
}
