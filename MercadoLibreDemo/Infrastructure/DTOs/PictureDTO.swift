//
//  PictureDTO.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/31/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

struct PictureDTO {
    let id: String
    let url: String

    var toPicture: Picture {
        return Picture(id: id, url: url)
    }
}

extension PictureDTO: Decodable {
    enum Key: String, CodingKey {
        case id, url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        id = try container.decode(String.self, forKey: .id)
        url = try container.decode(String.self, forKey: .url)
    }
}
