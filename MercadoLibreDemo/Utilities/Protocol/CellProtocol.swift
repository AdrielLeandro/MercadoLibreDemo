//
//  CellProtocol.swift
//  MercadoLibreDemo
//
//  Created by Adriel on 8/29/20.
//  Copyright © 2020 Adriel Pinzas. All rights reserved.
//

import UIKit
import Foundation

protocol CellProtocol: class {
    static var identifier: String { get }
}

extension CellProtocol where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func dequeueReusableCell<T>(forIndexPath indexPath: IndexPath) -> T where T: CellProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
}
