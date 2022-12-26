//
//  GradientButtonBackGround.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 06/12/22.
//

import Foundation
import UIKit


extension UIView {
    func applyGradient(colours: [UIColor], cornerRadius: CGFloat) -> CAGradientLayer {
        return self.applyGradient(colours: colours,cornerRadius: cornerRadius, locations: nil)
    }

    func applyGradient(colours: [UIColor],cornerRadius: CGFloat, locations: [NSNumber]?) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

class GradientButton: UIButton {
    let gradient: CAGradientLayer = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpButtonBackGround(colours: [UIColor],cornerRadius: CGFloat) {
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.cornerRadius = cornerRadius
        self.layer.insertSublayer(gradient, at: 0)
    }
}
