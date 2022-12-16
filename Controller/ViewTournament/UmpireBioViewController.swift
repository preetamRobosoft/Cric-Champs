//
//  UmpireBioViewController.swift
//  Cricket
//
//  Created by Preetam G on 10/12/22.
//

import UIKit

class UmpireBioViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var customProfileView: ProfilePhotoImageView!
    @IBOutlet weak var triangleView: TriangleView!
    @IBOutlet weak var profileImage: CustomImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.setCornerRadius()
        configureButtons()
        customProfileView.setRadius()
    }
    
    func configureButtons() {
        
        _ = self.proceedButton.applyGradient( colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 4)
    }
    @IBAction func onDeleteButtonClick(_ sender: Any) {
    }
    
}
