//
//  LandingView.swift
//  Squares
//
//  Created by mac on 29.11.2021.
//

import UIKit
import RxSwift

public enum F {
   
    typealias VoidFunc = () -> ()
}

public enum States {
    
    case nextClick
}

class LandingView: UIView {

    // MARK: -
    // MARK: Variables
    
    @IBOutlet weak var square: UIView?
    @IBOutlet weak var nextButton: UIButton?
    
    public var viewStatesHandler = PublishSubject<States>()
    
    // MARK: -
    // MARK: Public
    
    public func moveSquare(to position: Positions, animated: Bool, completion: F.VoidFunc?) {
        let point = self.origin(from: position)
        
        if animated {
            LandingView.animate(
                withDuration: 1,
                animations: { self.square?.frame.origin = point },
                completion: { _ in completion?() }
            )
        } else {
            self.square?.frame.origin = point
            completion?()
        }
    }
    
    public func origin(from position: Positions) -> CGPoint {
        let bound = self.bounds
        let size = self.square?.bounds.size ?? .zero
        
        switch position {
        case .leftUp:
            return CGPoint(x: bound.minX, y: bound.minY)
        case .rightUp:
            return CGPoint(x: bound.maxX - size.width, y: bound.minY)
        case .leftBottom:
            return CGPoint(x: bound.minX, y: bound.maxY - size.height)
        case .rightBottom:
            return CGPoint(x: bound.maxX - size.width, y: bound.maxY - size.height)
        }
    }
        
    // MARK: -
    // MARK: Private
    
    @IBAction private func onClickNextButton(_ sender: Any) {
        self.viewStatesHandler.onNext(.nextClick)
    }
}
