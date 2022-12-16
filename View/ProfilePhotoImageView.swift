//
//  ProfilePhotoImageView.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 07/12/22.
//
import UIKit
 
class ProfilePhotoImageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    
    }
    
    
    func setRadius() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        self.layer.cornerRadius = self.bounds.width / 2
    }
    
}
