//
//  Font.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import Foundation
import UIKit

class Font {
    private var fontFamily: FontFamily = .roboto
    private var fontSize: StandardSize = .medium
    private var weight: Weight = .regular

    @discardableResult
    func setFontFamily(fontFamily: FontFamily) -> Font {
        self.fontFamily = fontFamily
        return self
    }

    @discardableResult
    func setSize(fontSize: StandardSize) -> Font {
        self.fontSize = fontSize
        return self
    }

    @discardableResult
    func setWeight(weight: Weight) -> Font {
        self.weight = weight
        return self
    }

    func builder() -> UIFont {
        switch fontFamily {
        case .system: return getSystemFont()
        case .roboto: return getInstalledFont()
        }
    }

    private func getInstalledFont() -> UIFont {
        return UIFont(name: fontFamily.fontName(weight: weight), size: fontSize.rawValue) ?? getSystemFont()
    }

    private func getSystemFont() -> UIFont {
            switch weight {
            case .light:
                return UIFont.systemFont(ofSize: fontSize.rawValue, weight: UIFont.Weight.light)
            case .regular:
                return UIFont.systemFont(ofSize: fontSize.rawValue, weight: UIFont.Weight.regular)
            case .semibold:
                return UIFont.systemFont(ofSize: fontSize.rawValue, weight: UIFont.Weight.semibold)
            case .bold:
                return UIFont.systemFont(ofSize: fontSize.rawValue, weight: UIFont.Weight.bold)
            }
    }

    enum FontFamily {
        case roboto
        case system

        func fontName(weight: Weight) -> String {
            switch self {
            case .roboto: return "Roboto\(weight.rawValue)"
            case .system: return ""
            }
        }
    }

    enum Weight: String {
        case light = "-Light"
        case regular = "-Regular"
        case semibold = "-Black"
        case bold = "-Bold"
    }

    enum StandardSize: CGFloat {
        case extraSmall = 10
        case small = 12
        case medium = 14
        case large = 16
        case extraLarge = 20
        case superLarge = 24
        case hyperLarge = 50
    }
}

extension UIFont {
    static func robotoRegularFontSize10() -> UIFont {
        return Font().setFontFamily(fontFamily: .roboto)
            .setSize(fontSize: .extraSmall)
            .setWeight(weight: .regular).builder()
    }
    static func robotoRegularFontSize12() -> UIFont {
        return Font().setFontFamily(fontFamily: .roboto)
            .setSize(fontSize: .small)
            .setWeight(weight: .regular).builder()
    }
    static func robotoRegularFontSize14() -> UIFont {
        return Font().setFontFamily(fontFamily: .roboto)
            .setSize(fontSize: .medium)
            .setWeight(weight: .regular).builder()
    }

    static func robotoRegularFontSize16() -> UIFont {
        return Font().setFontFamily(fontFamily: .roboto)
            .setSize(fontSize: .large)
            .setWeight(weight: .regular).builder()
    }

    static func robotoRegularFontSize20() -> UIFont {
        return Font().setFontFamily(fontFamily: .roboto)
            .setSize(fontSize: .extraLarge)
            .setWeight(weight: .regular).builder()
    }

    static func robotoRegularFontSize24() -> UIFont {
        return Font().setFontFamily(fontFamily: .roboto)
            .setSize(fontSize: .superLarge)
            .setWeight(weight: .regular).builder()
    }

    static func robotoRegularFontSize50() -> UIFont {
        return Font().setFontFamily(fontFamily: .roboto)
            .setSize(fontSize: .hyperLarge)
            .setWeight(weight: .regular).builder()
    }

    static func robotoBoldFontSize20() -> UIFont {
         return Font().setFontFamily(fontFamily: .roboto)
             .setSize(fontSize: .extraLarge)
            .setWeight(weight: .bold).builder()
     }

    static func robotoBoldFontSize24() -> UIFont {
         return Font().setFontFamily(fontFamily: .roboto)
             .setSize(fontSize: .superLarge)
            .setWeight(weight: .bold).builder()
     }
}
