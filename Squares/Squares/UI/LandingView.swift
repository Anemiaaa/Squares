//
//  LandingView.swift
//  Squares
//
//  Created by mac on 29.11.2021.
//

import UIKit

class LandingView: UIView {

    @IBOutlet weak var square: UIView!

    // MARK: -
    // MARK: Variables
    
    //private(set) var squarePosition: Positions = Positions.leftUp
    
    // MARK: -
    // MARK: Initialization
    
    public init(rect: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        self.square.frame = rect
        self.square.backgroundColor = UIColor.cyan
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
    }
    
    @IBAction func onClickRightTopButton(_ sender: Any) {
    }
    
    @IBAction func onClickLeftDownButton(_ sender: Any) {
    }
    
    @IBAction func onCLickRightDownButton(_ sender: Any) {
    }
    
    
}
