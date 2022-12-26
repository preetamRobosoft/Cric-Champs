//
//  SuccessFailViewController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 07/12/22.
//

import UIKit

class SuccessFailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var messageTitle: UILabel!
    @IBOutlet weak var messageSubTitle: UILabel!
    @IBOutlet weak var messageDescription: UILabel!
    
    var didSuccessfullyRegister: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    func configure() {
        if didSuccessfullyRegister {
            image.image = #imageLiteral(resourceName: "AwesomeBall")
            messageTitle.text = "Awesome!!"
            messageSubTitle.text = "You have Successfully Registered."
            messageDescription.text = "Kindly open the verification email we sentto your registered email ID and verifyyour account."
        } else {
            image.image = #imageLiteral(resourceName: "Oopsball")
            messageTitle.text = "Oops!!"
            messageSubTitle.text = "Something went wrong."
            messageDescription.text = "Kindly check if all the details entered byyou are proper. If problem persists then check back after sometime."
        }
    }
    @IBAction func onBackTapped(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: false)
                break
            }
        }
    }
    
    @IBAction func onClickCreateTournament(_ sender: Any) {
       
    }
}
