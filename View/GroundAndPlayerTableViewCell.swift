//
//  PlayerAndGroundTableViewCell.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 10/12/22.
//

import UIKit

enum PlayerInfo: String {
    case batting = "Batting"
    case bowling = "Bowling"
    case wicketKeeper = "WicketKeeper"
    case allRounder = "AllRounder"
    case captain = "Captain"
    case viceCaptain = "ViceCaptain"
}

class GroundAndPlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var cellBackGround: UIView!
    
    @IBOutlet weak var profileImage: CustomImageView!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var designation: UILabel!
    
    func setData(data: Any) {
        cellBackGround.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        designation.isHidden = true
        profileImage.setCornerRadius()
        if let data = data as? Player {
            setDataforPlayer(data: data)
        } else if  let data = data as? Ground {
            setDataForGround(data: data)
        }
    }
    
    private func setDataforPlayer(data: Player) {
        name.text = data.name.capitalized
        let result = setExpertiseForPLayer(data: data)
        self.title.text = result
        if data.designation == PlayerInfo.captain.rawValue {
            designation.isHidden = false
            designation.text = PlayerInfo.captain.rawValue.uppercased()
            designation.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        } else if data.designation == PlayerInfo.viceCaptain.rawValue {
            designation.isHidden = false
            designation.text = PlayerInfo.captain.rawValue.uppercased()
            designation.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        } else if data.designation == PlayerInfo.wicketKeeper.rawValue {
            designation.isHidden = false
            designation.text = PlayerInfo.captain.rawValue.uppercased()
            designation.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        }
        guard  let imageUrl = URL(string: (data.profilePhoto as? String) ?? "" ) else {
            return
        }
        guard  let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        profileImage.image = UIImage(data: imageData)
    }
    
    private func setDataForGround(data: Ground) {
        name.text = data.groundName.capitalized
        title.text = data.city.capitalized
        guard  let imageUrl = URL(string: (data.groundPhoto as? String) ?? "" ) else {
            profileImage.image = #imageLiteral(resourceName: "ground1")
            return
        }
        guard  let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        profileImage.image = UIImage(data: imageData)
    }
    
    
    private func setExpertiseForPLayer(data: Player) -> String {
        switch data.expertise {
        case PlayerInfo.batting.rawValue: return (data.batting ?? "") + " Batsman"
            
        case PlayerInfo.bowling.rawValue: return (data.bowling ?? "") + " Bowler"

        case PlayerInfo.wicketKeeper.rawValue: return data.expertise ?? ""

        case PlayerInfo.allRounder.rawValue: return data.expertise ?? ""

        default:
            return ""
        }
    }
}
