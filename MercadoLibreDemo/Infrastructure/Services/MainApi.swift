//
//  MainApi.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Moya

enum MainApi {
    case search(parameters: [String: Any])
    case product(id: String)
    case categories
}

extension MainApi: TargetType {
    var sampleData: Data {
        return Data()
    }

    var baseURL: URL {
        guard let url = URL(string: Paths.baseUrl) else { return URL(fileURLWithPath: "") }
        return url
    }

    var path: String {
        switch self {
        case .search:
            return "\(Paths.sites)\(Paths.search)"
        case .product(id: let id):
            return "\(Paths.items)/\(id)"
        case .categories:
            return "\(Paths.sites)\(Paths.categories)"
        }
    }

    var method: Method {
        return .get
    }

    var task: Task {
        switch self {
        case .search(parameters: let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .product:
            return .requestPlain
        case .categories:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return nil
    }
}
