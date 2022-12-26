//
//  Ground.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 21/12/22.
//

import Foundation

struct Ground {
    var id: Int64?
    var tournamentId: Int64?
    var groundName: String
    var city: String
    let groundLocation: String?
    var latitude: Double
    var longitude: Double
    var groundPhoto: Any?
    var isSaved = false
}
