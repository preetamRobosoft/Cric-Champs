//
//  HomeTableViewCell.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 06/12/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var tournamentName: UILabel!
    @IBOutlet weak var tournamentCode: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var matchStatus: MatchStatusLabel!
    func designCell() {
        backView.layer.masksToBounds = false
        backView.layer.cornerRadius = 10
        backView.backgroundColor = .white
    }
    
    func setValues(index: Int) {
        if index % 2 == 0 {
            matchStatus.setUpInprogress()
        } else {
            matchStatus.setUpCompleted()
        }
    }
}
