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

public struct Positions {
    
    let leftUp: CGPoint
    let rightUp: CGPoint
    let leftBottom: CGPoint
    let rightBottom: CGPoint
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
    
    public var positions: Positions
    
    var rootView: LandingView?
    
    private var currentPosition: CGPoint
    
    // MARK: -
    // MARK: Initialization
    
    init() {
        self.positions = Positions(leftUp: CGPoint(x: 0, y: 0),
                                   rightUp: CGPoint(x: Default.screenSize.width - Default.squareSide, y: 0),
                                   leftBottom: CGPoint(x: 0, y: Default.screenSize.height - Default.squareSide),
                                   rightBottom: CGPoint(x: Default.screenSize.width - Default.squareSide, y: Default.screenSize.height - Default.squareSide))
        
        self.currentPosition = self.positions.leftUp
        
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public
    
    public func set(squarePosition: CGPoint) {
        self.rootView?.moveSquare(to: squarePosition, animated: false, completion: { [weak self] in
            self?.currentPosition = squarePosition
        })
    }
    
    public func set(squarePosition: CGPoint, animated: Bool) {
        self.rootView?.moveSquare(to: squarePosition, animated: animated, completion: { [weak self] in
            self?.currentPosition = squarePosition
        })
    }
    
    public func set(squarePosition: CGPoint, animated: Bool, completion: @escaping () -> ()) {
        self.rootView?.moveSquare(to: squarePosition, animated: animated, completion: { [weak self] in
            self?.currentPosition = squarePosition
            
            completion()
        })
    }
    
    public func viewInstance() -> View? {
        return self.rootView
    }
    
    // MARK: -
    // MARK: Private
    
//    private func point(to position: Positions, squareSide: CGFloat) -> CGPoint {
//        switch position {
//        case .leftUp:
//            return CGPoint(x: 0, y: 0)
//        case .rightUp:
//            return CGPoint(x: Default.screenSize.width - squareSide, y: 0)
//        case .leftBottom:
//            return CGPoint(x: 0, y: Default.screenSize.height - squareSide)
//        case .rightBottom:
//            return CGPoint(x: Default.screenSize.width - squareSide, y: Default.screenSize.height - squareSide)
//        }
//    }
    
    // MARK: -
    // MARK: Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView = LandingView(rect: CGRect(origin: self.positions.leftUp, size: CGSize(width: Default.squareSide, height: Default.squareSide)))
    }
}
