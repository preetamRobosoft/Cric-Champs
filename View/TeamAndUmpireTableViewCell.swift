//
//  TeamAndUmpireTableViewCell.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 10/12/22.
//

import UIKit

class TeamAndUmpireTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackGroundView: UIView!
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var name: UILabel!
    
    func setData(data: Any) {
        cellBackGroundView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cellBackGroundView.layer.masksToBounds = true
        profileImage.setCornerRadius()
        if let data = data as? Team {
            setUpDataForTeam(team: data)
        }
        if let data = data as? Umpire {
            setUpDataForUmpire(umpire: data)
        }
        if let data = data as? TeamInfo {
            setUpDataForTeamInfo(team: data)
        }
    }
    
    private func setUpDataForTeam(team: Team) {
        self.name.text = team.name
        guard  let imageUrl = URL(string: (team.logo as? String) ?? "" ) else {
            return
        }
        guard  let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        profileImage.image = UIImage(data: imageData)
    }
    
    private func setUpDataForTeamInfo(team: TeamInfo) {
        self.name.text = team.teamName
        guard  let imageUrl = URL(string: (team.teamLogo)) else {
            return
        }
        guard  let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        profileImage.image = UIImage(data: imageData)
    }
    
    private func setUpDataForUmpire(umpire: Umpire) {
        self.name.text = umpire.name
        guard  let imageUrl = URL(string: (umpire.profile as? String) ?? "" ) else {
            return
        }
        guard  let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        profileImage.image = UIImage(data: imageData)
    }
}
