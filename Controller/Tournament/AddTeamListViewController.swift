//
//  AddTeamListViewController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 10/12/22.
//

import UIKit
import Foundation

class AddTeamListViewController: UIViewController {
    var tournamentViewModel = TournamentViewModel.shared
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTeam: CustomButton!
    @IBOutlet weak var proceedButton: GradientButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        registerCell()
        addTeam.setUpButton(color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), cornerRadius: addTeam.bounds.height / 2)
        tableView.delegate = self
        tableView.dataSource = self
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tournamentViewModel.fetchTeam{ success, error in
            DispatchQueue.main.async {
                if success {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "EmptyDataCell", bundle: nil), forCellReuseIdentifier: "emptyDataCell")
        tableView.register(UINib(nibName: "TeamAndUmpireTableViewCell", bundle: nil), forCellReuseIdentifier: "teamAndUmpireCell")
    }

    @IBAction func onClickAddTeam(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddTeamViewController") as! AddTeamViewController
        tournamentViewModel.currentTeam = nil
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickProceed(_ sender: Any) {
        if tournamentViewModel.teams.count >= 2 {
            let vc = storyboard?.instantiateViewController(identifier: "OversViewController") as? OversViewController
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    private func enableProceedButton() {
        proceedButton.isEnabled = true
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    private func disableProceedButton() {
        proceedButton.isEnabled = false
        proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    private func disableAddTeamButton() {
        addTeam.isEnabled = false
        addTeam.setUpButton(color: #colorLiteral(red: 0.5803921569, green: 0.5764705882, blue: 0.5921568627, alpha: 1), cornerRadius: addTeam.bounds.height / 2)
    }
}

extension AddTeamListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tournamentViewModel.teams.count == 0 {
            disableProceedButton()
            return 1
        }
        else {
            if tournamentViewModel.teams.count >= tournamentViewModel.minimumNumberOfTeams {
               enableProceedButton()
                if tournamentViewModel.isIndividualMatch {
                    disableAddTeamButton()
                }
            } else {
                disableProceedButton()
            }
            return tournamentViewModel.teams.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tournamentViewModel.teams.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyDataCell") as? EmptyDataCell
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamAndUmpireCell") as! TeamAndUmpireTableViewCell
            cell.setData(data: tournamentViewModel.teams[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tournamentViewModel.teams.count > 0 {
            let vc = storyboard?.instantiateViewController(identifier: "AddTeamViewController") as! AddTeamViewController
            tournamentViewModel.currentTeam = tournamentViewModel.teams[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
