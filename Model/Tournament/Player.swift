//
//  Player.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 20/12/22.
//

import Foundation
import UIKit

struct Player {
    var teamId: Int64?
    var name: String
    var place: String?
    var phone: String?
    var designation: String?
    var expertise: String?
    var batting: String?
    var bowling: String?
    var bowlingType: String?
    var profilePhoto: Any?
    var isSaved = false
}

struct Team {
    var id: Int64
    var name: String
    var place: String?
    var logo: Any?
    var isSaved: Bool?
}

