//
//  TournamentOverviewVC.swift
//  Cricket
//
//  Created by Preetam G on 12/12/22.
//

import UIKit

class TournamentOverviewVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
        
    }
    private func registerCell() {
        tableView.register(UINib(nibName: "OverViewCell", bundle: nil), forCellReuseIdentifier: "overViewCell")
    }
}

extension TournamentOverviewVC: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 8
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "overViewCell") as? OverViewCell else {
        return UITableViewCell()
    }
    cell.setData()
    return cell
}
}
