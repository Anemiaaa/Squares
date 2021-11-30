//
//  Extensions.swift
//  Squares
//
//  Created by mac on 29.11.2021.
//

import Foundation
import UIKit

extension UIViewController {

    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
