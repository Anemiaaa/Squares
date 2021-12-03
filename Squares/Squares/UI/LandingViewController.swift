//
//  LandingViewController.swift
//  Squares
//
//  Created by mac on 29.11.2021.
//

import UIKit
import RxCocoa
import RxSwift

public enum Positions {
    
    case leftUp
    case rightUp
    case leftBottom
    case rightBottom
    case center
}

class LandingViewController: UIViewController, RootViewGettable {

    // MARK: -
    // MARK: Typealias
    
    typealias View = LandingView
    
    // MARK: -
    // MARK: Variables
    
    struct Default {
        
        static let screenSize = UIScreen.main.bounds
        static let squareSide = 100
    }
    
    //public var positions: Positions
    
    var rootView: LandingView?
    
    private var disposeBag = DisposeBag()
    private var currentPosition: Positions
    
    // MARK: -
    // MARK: Initialization
    
    init() {
        self.currentPosition = .leftUp
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public
    
    public func set(squarePosition: Positions) {
        self.rootView?.moveSquare(to: squarePosition, animated: false, completion: { [weak self] in
            self?.currentPosition = squarePosition
        })
    }
    
    public func set(squarePosition: Positions, animated: Bool) {
        self.rootView?.moveSquare(to: squarePosition, animated: animated, completion: { [weak self] in
            self?.currentPosition = squarePosition
        })
    }
    
    public func set(squarePosition: Positions, animated: Bool, completion: @escaping () -> ()) {
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
            let position: Positions
            
            switch viewStates {
            case .leftUpClick:
                position = .leftUp
            case .rightUpClick:
                position = .rightUp
            case .leftDownClick:
                position = .leftBottom
            case .rightDownClick:
                position = .rightBottom
            }
            
            self.set(squarePosition: position, animated: true)
        }
        .disposed(by: self.disposeBag)
    }
    
    // MARK: -
    // MARK: Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let size = CGSize(width: Default.squareSide, height: Default.squareSide)
        self.rootView = LandingView(position: .leftUp, size: size)
        
        self.prepareObservingView()
    }
}
