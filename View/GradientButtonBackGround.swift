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

