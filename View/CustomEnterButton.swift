//
//  CustomEnterButton.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 06/12/22.
//

import Foundation
import UIKit

class CustomEnterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpButton()
    }
    
    private func setUpButton() {
        self.layer.borderColor = #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 4
        self.setTitleColor(#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1), for: .normal)
    }
}

