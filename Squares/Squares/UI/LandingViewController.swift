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
    
    private var disposeBag = DisposeBag()
    private var currentPosition: Positions
    private var workItem: DispatchWorkItem?
    
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
    
    // MARK: -
    // MARK: Private

    private func prepareObservingView() {
        guard let rootView = self.rootView else {
            return
        }
        
        rootView.viewStatesHandler.bind { viewStates in
            if let workItem = self.workItem, !workItem.isCancelled {
                workItem.cancel()
                self.workItem = nil
            }
            
            self.workItem = DispatchWorkItem {
                let position: Positions
                
                switch viewStates {
                case .nextClick:
                    position = self.switchPosition(position: self.currentPosition)
                }
                
    //            currentPosition = rootView.square.frame.origin != rootView.origin(from: self.currentPosition) ? self.switchPosition(position: position) : position
                
                self.set(squarePosition: position, animated: true)
            }
            DispatchQueue.main.async(execute: self.workItem!)
        }
        .disposed(by: self.disposeBag)
    }
    
    private func switchPosition(position: Positions) -> Positions {
        switch self.currentPosition {
        case .leftUp:
            return .rightUp
        case .rightUp:
            return .rightBottom
        case .leftBottom:
            return .leftUp
        case .rightBottom:
            return .leftBottom
        }
    }
    
    // MARK: -
    // MARK: Overriden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareObservingView()
        self.rootView?.layoutIfNeeded();
    }
}
