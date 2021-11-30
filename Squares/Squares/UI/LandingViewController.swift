//
//  LandingViewController.swift
//  Squares
//
//  Created by mac on 29.11.2021.
//

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

public enum Positions {
    
    case leftUp
    case rightUp
    case leftBottom
    case rightBottom
}

class LandingViewController: UIViewController, RootViewGettable {

    // MARK: -
    // MARK: Typealias
    
    typealias View = LandingView
    
    // MARK: -
    // MARK: Variables
    
    struct Default {
        
        static let screenSize = UIScreen.main.bounds
        static let squareSide = screenSize.width / 4
    }
    
    // MARK: -
    // MARK: Public
    
    public func set(squarePosition: Positions) {
        self.rootView?.set(squarePosition: squarePosition, animated: false, completion: <#T##(() -> ())?##(() -> ())?##() -> ()#>)
    }
    
    public func set(squarePosition: Positions, animated: Bool) {}
    
    public func set(squarePosition: Positions, animated: Bool, completion: () -> ()) {}
    
    public func viewInstance() -> View? {
        return self.rootView
    }
    
    // MARK: -
    // MARK: Private
    
    private func point(to position: Positions, squareSide: CGFloat) -> CGPoint {
        switch position {
        case .leftUp:
            return CGPoint(x: 0, y: 0)
        case .rightUp:
            return CGPoint(x: Default.screenSize.width - squareSide, y: 0)
        case .leftBottom:
            return CGPoint(x: 0, y: Default.screenSize.height - squareSide)
        case .rightBottom:
            return CGPoint(x: Default.screenSize.width - squareSide, y: Default.screenSize.height - squareSide)
        }
    }
    
    // MARK: -
    // MARK: Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
