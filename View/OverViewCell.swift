//
//  OverViewCellTableViewCell.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 11/12/22.
//

import UIKit

class OverViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var titleOverView: UILabel!
    
    func setData() {
        title.text = "Team"
        titleOverView.text = "6"
    }
}
