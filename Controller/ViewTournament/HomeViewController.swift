//
//  HomeViewController.swift
//  Cricket
//
//  Created by Preetam G on 06/12/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createTournament: UIButton!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var hamburgerMenuView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        tableView.delegate = self
        tableView.dataSource = self
        setScrollViewHeight()
    }
    
    override func viewDidLayoutSubviews() {
        setScrollViewHeight()
    }
    
    private func setUpView() {
        navigationController?.navigationBar.isHidden = true
        hamburgerMenuView.isHidden = true
        _ = self.createTournament.applyGradient(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(4))
    }
    
    func setScrollViewHeight() {
        let height = UIScreen.main.bounds.height
        
        if height > contentViewHeight.constant {
            contentViewHeight.constant = height
        }
    }
    
    @IBAction func onClickBurgerMenu(_ sender: Any) {

        buttonClick()
    }
    
    @IBAction func onClickCreateTournament(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        guard  let loginVc = vc else {
            return
        }
        navigationController?.pushViewController(loginVc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let menuVC = segue.destination as? MenuViewController else { return }
        menuVC.homeDelegate = self
    }
    
    private func buttonClick() {
        if hamburgerMenuView.isHidden {
            hamburgerMenuView.isHidden = false
        } else {
            hamburgerMenuView.isHidden = true
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? HomeTableViewCell
        cell?.designCell()
        cell?.setValues(index: indexPath.row)
        return cell!
    }
    
}

extension HomeViewController: HandleButtonAction {
    func callButtonAction() {
        buttonClick()
    }
    
}
