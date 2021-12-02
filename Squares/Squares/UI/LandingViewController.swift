//
//  LandingViewController.swift
//  Squares
//
//  Created by mac on 29.11.2021.
//

import UIKit
import RxCocoa
import RxSwift

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
    
    private var disposeBag = DisposeBag()
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

    private func prepareObservingView() {
        guard let rootView = rootView else {
            return
        }
        
        rootView.viewStatesHandler.bind { viewStates in
            let position: CGPoint
            
            switch viewStates {
            case .leftUpClick:
                position = self.positions.leftUp
            case .rightUpClick:
                position = self.positions.rightUp
            case .leftDownClick:
                position = self.positions.leftBottom
            case .rightDownClick:
                position = self.positions.rightBottom
            }
            
            self.set(squarePosition: position, animated: true)
        }.disposed(by: self.disposeBag)
    }
    
    // MARK: -
    // MARK: Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.rootView = LandingView(rect: CGRect(origin: self.positions.leftUp, size: CGSize(width: Default.squareSide, height: Default.squareSide)))
        
        self.prepareObservingView()
    }
}
