//
//  OverViewCellTableViewCell.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 11/12/22.
//

import UIKit

class OverViewCell: UITableViewCell {
    
    static let identifier = "overViewCell"
    static let nibName = "OverViewCell"

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var titleOverView: UILabel!
    
    func setData(string: String, overview text: String) {
        forwardButton.layer.cornerRadius = 12
        forwardButton.layer.masksToBounds = true
        title.text = string
        titleOverView.text = text
    }
}
