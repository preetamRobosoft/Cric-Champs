//
//  CustomEnterButton.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 06/12/22.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setUpButton(color: UIColor, cornerRadius: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = cornerRadius
        self.setTitleColor(color, for: .normal)
        
    }
}

