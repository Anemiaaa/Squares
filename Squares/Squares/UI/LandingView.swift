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

    // MARK: -
    // MARK: Variables
    
    @IBOutlet weak var figure: UIView?
    @IBOutlet weak var nextButton: UIButton?
    
    public var viewStatesHandler = PublishSubject<States>()
    
    // MARK: -
    // MARK: Public
    
    public func moveFigure(to position: Positions, animated: Bool, completion: F.VoidFunc?) {
        let startCorner: CGFloat
        let endCorner: CGFloat
        let endColor: UIColor
        let point = self.origin(from: position)
        
        if position == .leftUp || position == .rightUp {
            startCorner = 0
            endCorner = (self.figure?.bounds.size.width ?? 0) / 2
            endColor = position == .leftUp ? .systemTeal : .cyan
        }
        else {
            startCorner = (self.figure?.bounds.size.width ?? 0) / 2
            endCorner = 0
            endColor = position == .rightBottom ? .green : .blue
        }
        
        
        if animated {
            
            CATransaction.begin()
            
            CATransaction.setAnimationDuration(2)
            CATransaction.setCompletionBlock {
                completion?()
            }

            self.switchSquareCircle(from: startCorner, to: endCorner, duration: 2)
            self.changeColor(to: endColor, duration: 2)
            self.move(to: point, duration: 2)
            
            CATransaction.commit()
            
        } else {
            self.figure?.frame.origin = point
            self.figure?.layer.cornerRadius = endCorner
            
            completion?()
        }
    }
    
    public func origin(from position: Positions) -> CGPoint {
        let bound = self.bounds
        let size = self.figure?.bounds.size ?? .zero
        
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
    
    private func switchSquareCircle(from start: CGFloat, to end: CGFloat, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "circle")
        
        animation.fromValue = start
        animation.toValue = end
        animation.duration = duration
        
        self.figure?.layer.add(animation, forKey: "circle")
    }
    
    private func changeColor(to color: UIColor, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "color")
        
        animation.fromValue = self.figure?.backgroundColor
        animation.toValue = color
        animation.duration = duration
        
        self.figure?.layer.add(animation, forKey: "color")
    }
    
    private func move(to point: CGPoint, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "movement")
        
        animation.fromValue = self.figure?.frame.origin
        animation.toValue = point
        animation.duration = duration
        
        self.figure?.layer.add(animation, forKey: "movement")
    }
}
