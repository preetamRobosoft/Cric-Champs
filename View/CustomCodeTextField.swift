//
//  CustomCodeTextField.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 06/12/22.
//

import UIKit
import Foundation


class CustomCodeTextField: UITextField {

    class CustomEnterButton: UIButton {
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUpTextField()
        }
        
        private func setUpTextField() {
            self.layer.borderColor = #colorLiteral(red: 0.6156862745, green: 0.7176470588, blue: 0.8392156863, alpha: 1)
            self.layer.borderWidth = 1
        }
    }
}
