//
//  LandingView.swift
//  Squares
//
//  Created by mac on 29.11.2021.
//

import UIKit
import RxSwift

public enum States {
    
    case leftUpClick
    case rightUpClick
    case leftDownClick
    case rightDownClick
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
            LandingView.animate(withDuration: 0.5) {
                self.square.frame.origin = point
            } completion: { _ in
                completion?()
            }

        } else {
            self.square.frame.origin = point
            completion?()
        }
    }
        
    // MARK: -
    // MARK: Private
    
    private func origin(from position: Positions) -> CGPoint {
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
        case .center:
            point = CGPoint(
                x: self.center.x - size.width / 2,
                y: self.center.y - size.height / 2
            )
        }
        return point
    }
    
    // MARK: -
    // MARK: Overriden
    
    override func awakeFromNib() {
        self.square.backgroundColor = .cyan
    }
    
    @IBAction func onClickLeftTopButton(_ sender: Any) {
        self.viewStatesHandler.onNext(.leftUpClick)
    }
    
    @IBAction func onClickRightTopButton(_ sender: Any) {
        self.viewStatesHandler.onNext(.rightUpClick)
    }
    
    @IBAction func onClickLeftDownButton(_ sender: Any) {
        self.viewStatesHandler.onNext(.leftDownClick)
    }
    
    @IBAction func onCLickRightDownButton(_ sender: Any) {
        self.viewStatesHandler.onNext(.rightDownClick)
    }
}
