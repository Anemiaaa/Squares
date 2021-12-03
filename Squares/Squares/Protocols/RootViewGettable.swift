//
//  RootViewGettable.swift
//  Squares
//
//  Created by mac on 02.12.2021.
//

import Foundation
import UIKit

protocol RootViewGettable {
    
    associatedtype View: UIView
    
    var rootView: View? { get }
}

extension RootViewGettable where Self: UIViewController {
    
    var rootView: View? {
        return self.view as? View
    }
}
