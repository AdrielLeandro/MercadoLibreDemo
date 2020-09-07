//
//  Color+Extension.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        var hexFormatted = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

         if hexFormatted.hasPrefix("#") {
             hexFormatted = String(hexFormatted.dropFirst())
         }

         assert(hexFormatted.count == 6, "Invalid hex code used.")

         var rgbValue: UInt64 = 0
         Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

         self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                   green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                   blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                   alpha: alpha)
    }

    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}

extension UIColor {
    static var lightYellow: UIColor {
        return UIColor(hexString: "#FFF066")
    }

    static var anchor: UIColor {
        return UIColor(hexString: "#3E424B")
    }

    static var cobalt: UIColor {
        return UIColor(hexString: "#1335BE")
    }

    static var forest: UIColor {
        return UIColor(hexString: "#0B6623")
    }
}
