//
//  OnboardingViewController.swift
//  Cricket
//
//  Created by Preetam G on 06/12/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var index = 0
    var heading = ""
    var imageFile = ""
    var content = ""
    
    @IBOutlet var headingLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var contentImageView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var forwardButton: UIButton!
    @IBOutlet weak var skip: UIButton!
    @IBOutlet weak var visualView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        
        visualView.constant = view.bounds.height - 70
        skip.isHidden = false
        self.headingLabel.text = heading
        self.contentLabel.text = content
        self.contentImageView.image = UIImage(named: imageFile)
        self.pageControl.currentPage = index
        
        switch index {
        case 0...1: forwardButton.setTitle("NEXT", for: .normal)
        case 2: forwardButton.setTitle("LET'S START", for: .normal)
        default: break
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        headingLabel.text = heading
        contentLabel.text = content
        contentImageView.image = UIImage(named: imageFile)
        pageControl.currentPage = index
    }
    
    @IBAction func nextButtonTapped(sender: UIButton) {
        
        switch index {
        case 0...1:
            let vc = self.parent as! MainPageController
            vc.forward(index: index)
            
        case 2:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
    
    @IBAction func skipButtonTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
