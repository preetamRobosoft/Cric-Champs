//
//  GroundsViewController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 10/12/22.
//

import UIKit

class GroundsViewController: UIViewController {

    var tournamentViewModel = TournamentViewModel.shared
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var proceedButton: GradientButton!
    @IBOutlet weak var addGround: CustomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
        addGround.setUpButton(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cornerRadius: addGround.bounds.height / 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tournamentViewModel.fetchGrounds{ success, error in
            DispatchQueue.main.async {
                if success {
                    self.tableView.reloadData()
                } else {
                    alertAction(controller: self, message: error?.localizedDescription ?? "Uknown Error")
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    
    private func registerCell() {
        tableView.register(UINib(nibName: "GroundAndPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerAndGround")
        tableView.register(UINib(nibName: "EmptyDataCell", bundle: nil), forCellReuseIdentifier: "emptyDataCell")
    }
    
    @IBAction func onClickAddGround(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddGroundViewController") as? AddGroundViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func onClickProceedButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "UmpiresViewController") as? UmpiresViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
    
    }
}

extension GroundsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tournamentViewModel.grounds.count == 0 {
            proceedButton.isEnabled = false
            proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)], cornerRadius: CGFloat(0))
            return 1
        } else {
            proceedButton.isEnabled = true
            proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
            return tournamentViewModel.grounds.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tournamentViewModel.grounds.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyDataCell") as? EmptyDataCell
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerAndGround") as! GroundAndPlayerTableViewCell
            cell.setData(data: tournamentViewModel.grounds[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tournamentViewModel.grounds.count > 0 {
            tournamentViewModel.currentGround = tournamentViewModel.grounds[indexPath.row]
            let vc = storyboard?.instantiateViewController(identifier: "AddGroundViewController") as? AddGroundViewController
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
