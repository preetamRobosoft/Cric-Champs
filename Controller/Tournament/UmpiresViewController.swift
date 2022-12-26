//
//  UmpiresViewController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 10/12/22.
//

import UIKit

class UmpiresViewController: UIViewController {
    
    var tournamentViewModel = TournamentViewModel.shared
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var proceedButton: GradientButton!
    @IBOutlet weak var addUmpire: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
        addUmpire.setUpButton(color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), cornerRadius: addUmpire.bounds.height / 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tournamentViewModel.fetchUmpire { success, error in
            DispatchQueue.main.async {
                if success {
                    self.tableView.reloadData()
                } else {
                    alertAction(controller: self, message: error?.localizedDescription ?? "Error")
                }
            }
        }
    }
    
    private func setUpProceedButton() {
        proceedButton.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUpProceedButton()
        proceedButton.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "TeamAndUmpireTableViewCell", bundle: nil), forCellReuseIdentifier: "teamAndUmpireCell")
        tableView.register(UINib(nibName: "EmptyDataCell", bundle: nil), forCellReuseIdentifier: "emptyDataCell")
    }
    
    @IBAction func onClickAddUmpire(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddUmpireViewController") as? AddUmpireViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onClickProceed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "CalenderVC") as? CalenderVC
        navigationController?.pushViewController(vc!, animated: true)
    }
    
}

extension UmpiresViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tournamentViewModel.umpires.count == 0 {
            proceedButton.isEnabled = false
            proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1), #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)], cornerRadius: CGFloat(0))
            return 1
        } else {
            proceedButton.isEnabled = true
            proceedButton.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
            return tournamentViewModel.umpires.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tournamentViewModel.umpires.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyDataCell") as? EmptyDataCell
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "teamAndUmpireCell") as! TeamAndUmpireTableViewCell
            cell.setData(data: tournamentViewModel.umpires[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tournamentViewModel.umpires.count > 0 {
            tournamentViewModel.currentUmpire = tournamentViewModel.umpires[indexPath.row]
            let vc = storyboard?.instantiateViewController(identifier: "AddUmpireViewController") as? AddUmpireViewController
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
}
