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
        let duration = CFTimeInterval(2)
        let point = self.figureCenter(for: position)
        let endColor = self.color(for: position)
        let endCorner = self.cornerRadius(for: position)
        
        if animated {
            
            CATransaction.begin()
            
            CATransaction.setAnimationDuration(duration)
            CATransaction.setCompletionBlock {
                self.setFigureConfigVariables(point: point, cornerRadius: endCorner, backgroundColor: endColor)
                
                completion?()
            }

            self.animatedSquareCircleSwitch(to: endCorner, duration: duration)
            self.animatedColorChange(to: endColor, duration: duration)
            self.animatedMove(to: point, duration: duration)
            
            CATransaction.commit()
            
        } else {
            self.setFigureConfigVariables(point: point, cornerRadius: endCorner, backgroundColor: endColor)
            
            completion?()
        }
    }
    
    public func figureCenter(for position: Positions) -> CGPoint {
        let bound = self.bounds
        let size = self.figure?.bounds ?? .zero
        
        switch position {
        case .leftUp:
            return CGPoint(x: size.width / 2, y: size.height / 2)
        case .rightUp:
            return CGPoint(x: bound.maxX - size.width / 2, y: bound.minY + size.height / 2)
        case .leftBottom:
            return CGPoint(x: bound.minX + size.width / 2, y: bound.maxY - size.height / 2)
        case .rightBottom:
            return CGPoint(x: bound.maxX - size.width / 2, y: bound.maxY - size.height / 2)
        }
    }
        
    // MARK: -
    // MARK: Private
    
    @IBAction private func onClickNextButton(_ sender: Any) {
        self.viewStatesHandler.onNext(.nextClick)
    }
    
    private func animatedSquareCircleSwitch(to end: CGFloat, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        
        animation.toValue = end
        animation.duration = duration
        
        self.figure?.layer.add(animation, forKey: "cornerRadius")
    }
    
    private func animatedColorChange(to color: CGColor, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        
        animation.toValue = color
        animation.duration = duration
        
        self.figure?.layer.add(animation, forKey: "backgroundColor")
    }
    
    private func animatedMove(to point: CGPoint, duration: CFTimeInterval) {
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.toValue = point
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        
        self.figure?.layer.add(animation, forKey: "position")
    }
    
    private func setFigureConfigVariables(point: CGPoint, cornerRadius: CGFloat, backgroundColor: CGColor) {
        self.figure?.center = point
        self.figure?.backgroundColor = UIColor(cgColor: backgroundColor)
        self.figure?.layer.cornerRadius = cornerRadius
    }
    
    private func cornerRadius(for position: Positions) -> CGFloat {
        let side = self.figure?.bounds.size.width ?? 0
        
        switch position {
        case .leftUp:
            return 0
        case .rightUp:
            return side / 2
        case .leftBottom:
            return 0
        case .rightBottom:
            return side / 2
        }
    }
    
    private func color(for position: Positions) -> CGColor {
        switch position {
        case .leftUp:
            return UIColor.systemTeal.cgColor
        case .rightUp:
            return UIColor.cyan.cgColor
        case .leftBottom:
            return UIColor.blue.cgColor
        case .rightBottom:
            return UIColor.green.cgColor
        }
    }
}
