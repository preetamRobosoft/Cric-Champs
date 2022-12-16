//
//  GroundImageCell.swift
//  Cricket
//
//  Created by Preetam G on 10/12/22.
//

import UIKit

class GroundImageCell: UICollectionViewCell {
    
    @IBOutlet private var groundImage: UIImageView!
    
    func configure(image: UIImage) {
        groundImage.image = image
    }
}
