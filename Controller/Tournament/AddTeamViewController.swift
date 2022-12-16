//
//  AddTeamViewController.swift
//  Cricket
//
//  Created by Preetam G on 09/12/22.
//

import UIKit

class AddTeamViewController: UIViewController {

    @IBOutlet weak var teamImageView: ProfilePhotoImageView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var teamImage: CustomImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setScrollViewHeight()
        teamImageView.setRadius()
        teamImage.setCornerRadius()
    }
    

    func setScrollViewHeight() {
        let height = UIScreen.main.bounds.height
        
        if height > contentViewHeight.constant {
            contentViewHeight.constant = height
        }
    }
    
    @IBAction func onClickCamera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

}

extension AddTeamViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fetchedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        teamImage.image = fetchedImage
//        registerVM.currentUser.profilePhoto = fetchedImage
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
