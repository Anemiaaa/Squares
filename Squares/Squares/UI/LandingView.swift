//
//  LandingView.swift
//  Squares
//
//  Created by mac on 29.11.2021.
//

import UIKit
import RxSwift

public enum States {
    
    case nextClick
}

class LandingView: UIView {

    @IBOutlet weak var square: UIView!

    // MARK: -
    // MARK: Variables
    
    public var viewStatesHandler = PublishSubject<States>()
    
    // MARK: -
    // MARK: Public
    
    public func moveSquare(to position: Positions, animated: Bool, completion: (() -> ())?) {
        let point = self.origin(from: position)
        
        if animated {
            LandingView.animate(
                withDuration: 1,
                animations: { self.square.frame.origin = point },
                completion: { _ in completion?() }
            )
        } else {
            self.square.frame.origin = point
            completion?()
        }
    }
    
    public func origin(from position: Positions) -> CGPoint {
        let bound = self.bounds
        let point: CGPoint
        let size = self.square.bounds.size
        
        switch position {
        case .leftUp:
            point = CGPoint(x: bound.minX, y: bound.minY)
        case .rightUp:
            point = CGPoint(x: bound.maxX - size.width, y: bound.minY)
        case .leftBottom:
            point = CGPoint(x: bound.minX, y: bound.maxY - size.height)
        case .rightBottom:
            point = CGPoint(x: bound.maxX - size.width, y: bound.maxY - size.height)
        }
        return point
    }
        
    // MARK: -
    // MARK: Private
    
    @IBAction private func onClickNextButton(_ sender: Any) {
        self.viewStatesHandler.onNext(.nextClick)
    }
    
    // MARK: -
    // MARK: Overriden
    
    override func awakeFromNib() {
        self.square.backgroundColor = .cyan
    }
}
