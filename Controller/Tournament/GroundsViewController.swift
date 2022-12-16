//
//  GroundsViewController.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 10/12/22.
//

import UIKit

class GroundsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        registerCell()
    }
    private func registerCell() {
        tableView.register(UINib(nibName: "GroundAndPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerAndGround")
    }
}

extension GroundsViewController: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerAndGround") as? GroundAndPlayerTableViewCell else {
        return UITableViewCell()
    }
    cell.setData()
    return cell
}
}
