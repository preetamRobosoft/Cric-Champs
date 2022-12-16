//
//  TeamAndUmpireTableViewCell.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 10/12/22.
//

import UIKit

class TeamAndUmpireTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackGroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func setData() {
        cellBackGroundView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        name.text = "Dhansuh"
        profileImage.image = #imageLiteral(resourceName: "profile4")
    }
}
