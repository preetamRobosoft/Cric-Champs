//
//  TriangleView.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 07/12/22.
//

import UIKit
class TriangleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

    override func draw(_ rect: CGRect) {

        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: (rect.maxX), y: rect.minY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY/1.5))
        context.closePath()

        context.setFillColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        context.fillPath()
    }

}
