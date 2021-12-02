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
    
    private let rect: CGRect
    
    // MARK: -
    // MARK: Initialization
    
    public init(rect: CGRect) {
        self.rect = rect
        
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -
    // MARK: Public
    
    public func moveSquare(to point: CGPoint, animated: Bool, completion: (() -> ())?) {
        if animated {
            LandingView.animate(withDuration: 0.5) {
                self.square.layer.position = point
            } completion: { _ in
                completion?()
            }

        } else {
            self.square.layer.position = point
            completion?()
        }
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
    
    // MARK: -
    // MARK: Overriden
    
    override func awakeFromNib() {
        self.square.frame = self.rect
        self.square.backgroundColor = UIColor.cyan
    }
}
