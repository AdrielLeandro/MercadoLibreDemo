//
//  SellerAddressDTO.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/30/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

struct SellerAddressDTO {
    let country: CountryDTO?
    let state: StateDTO?
    let city: CityDTO?

    var toCountry: Country {
        return Country(id: country?.id ?? "", name: country?.name ?? "")
    }

    var toCity: City {
         return City(id: city?.id ?? "", name: city?.name ?? "")
     }
    var toState: State {
        return State(id: state?.id ?? "", name: state?.name ?? "")
    }
}

extension SellerAddressDTO: Decodable {
    enum Key: String, CodingKey {
        case country, state, city
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        self.country = try? container.decode(CountryDTO.self, forKey: .country)
        self.state = try? container.decode(StateDTO.self, forKey: .state)
        self.city = try? container.decode(CityDTO.self, forKey: .city)
    }
}
