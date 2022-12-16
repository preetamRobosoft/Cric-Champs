//
//  MatchStatusLabel.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 06/12/22.
//

import UIKit

class MatchStatusLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpInprogress() {
        self.backgroundColor = #colorLiteral(red: 0.7215686275, green: 0.9137254902, blue: 0.5254901961, alpha: 1)
        self.text = "IN PROGRESS"
        self.textColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
    }
    
    func setUpCompleted() {
        self.backgroundColor = #colorLiteral(red: 1, green: 0.7294117647, blue: 0.4980392157, alpha: 1)
        self.text = "COMPLETED"
        self.textColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4
    }

}
