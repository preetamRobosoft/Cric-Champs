//
//  HomeViewController.swift
//  Cricket
//
//  Created by Preetam G on 06/12/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var homeViewModel = HomeViewModel.shared

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createTournament: GradientButton!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var enterButton: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        tableView.delegate = self
        tableView.dataSource = self
        setScrollViewHeight()
        enterButton.setUpButton(color: #colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1), cornerRadius: CGFloat(4))
    }
    
    override func viewDidLayoutSubviews() {
        setScrollViewHeight()
        createTournament.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.4901960784, blue: 0.4901960784, alpha: 1)], cornerRadius: CGFloat(4))
    }
    
    private func setUpView() {
        navigationController?.navigationBar.isHidden = true
        createTournament.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.4901960784, blue: 0.4901960784, alpha: 1)], cornerRadius: CGFloat(4))
    }
    
    func setScrollViewHeight() {
        let height = UIScreen.main.bounds.height
        
        if height > contentViewHeight.constant {
            contentViewHeight.constant = height
        }
    }
    
    @IBAction func onClickBurgerMenu(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        guard  let menuVc = vc else {
            return
        }
        navigationController?.present(menuVc)
    }
    
    @IBAction func onClickCreateTournament(_ sender: Any) {
        if homeViewModel.user == nil {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
            guard  let loginVc = vc else {
                return
            }
            loginVc.loginDelagate = self
            navigationController?.pushViewController(loginVc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "CreateTournamentViewController") as? CreateTournamentViewController
            guard  let tournamentVc = vc else {
                return
            }
            navigationController?.pushViewController(tournamentVc, animated: true)
        }
    }
    
    @IBAction func onClickEnter(_ sender: Any) {
        self.showToast(message: "Successful", controller: self)
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

extension HomeViewController: LoggedUser {
    func sendLoggedUser(user: User) {
        homeViewModel.user = user
    }
}

extension UINavigationController {

    func present(_ viewControllerToPresent: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: kCATransition)
        pushViewController(viewControllerToPresent, animated: true)
    }

    func dismiss() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)

        popViewController(animated: false)
    }
}
