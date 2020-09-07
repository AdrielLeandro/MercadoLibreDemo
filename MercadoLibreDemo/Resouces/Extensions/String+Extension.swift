//
//  String+Extension.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/31/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    func localizedFormat(_ arguments: CVarArg...) -> String {
        return String(format: localized, arguments: arguments)
    }

    func localizedFormat(arguments: CVarArg..., using tableName: String?, in bundle: Bundle?) -> String {
        return String(format: localized, arguments: arguments)
    }
}
