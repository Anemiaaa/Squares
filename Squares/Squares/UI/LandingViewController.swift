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
    
    private var disposeBag = DisposeBag()
    private var currentPosition: Positions = .leftUp
    private var destinationPosition: Positions?
    private var workItem: DispatchWorkItem?

    // MARK: -
    // MARK: Public
    
    public func set(squarePosition: Positions, animated: Bool = false, completion: F.VoidFunc? = nil) {
        self.rootView?.moveFigure(to: squarePosition, animated: animated) { [weak self] in
            self?.currentPosition = squarePosition
            
            completion?()
        }
    }
    
    // MARK: -
    // MARK: Private

    private func prepareObservingView() {
        rootView?.viewStatesHandler.bind { [weak self] viewStates in
            guard let self = self else { return }
            
            self.rootView?.nextButton?.isEnabled = false
            
            let next = self.workItem == nil
                ? self.nextPosition(by: self.currentPosition)
                : self.destinationPosition.map(self.nextPosition)
            
            guard let destination = next else { return }
            self.destinationPosition = next
            
            self.workItem?.cancel()
            self.workItem = DispatchWorkItem {
                self.set(squarePosition: destination, animated: true) {
                    self.workItem = nil
                    self.rootView?.nextButton?.isEnabled = true
                }
            }
            
            self.workItem.map(DispatchQueue.main.async)
        }
        .disposed(by: self.disposeBag)
    }
    
    private func nextPosition(by position: Positions) -> Positions {
        switch position {
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
    }
}
