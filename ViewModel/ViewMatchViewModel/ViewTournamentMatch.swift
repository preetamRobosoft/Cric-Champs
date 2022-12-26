//
//  ViewTournament.swift
//  Cric Champs
//
//  Created by Dhanush Devadiga on 26/12/22.
//

import Foundation

class ViewTournamentMatch {
    static var shared = ViewTournamentMatch()
    var network = NetworkManager()
    var grounds : [Ground] = []
    var getGroundHeader = [ "Authorization" : "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaGFudUBnbWFpbC5jb20iLCJleHAiOjE2NzIxMTEzOTEsImlhdCI6MTY3MjAyNDk5MX0.vWhcLFFUfZh70DbDIPnWrxuJmrBdt1NWln0glOTnD3c0Zek2RPVDccr1mq5WTyzSaEFv5P-zO2spUyyob12wsA","tournamentId" : "1"]
    
    var umpires = [Umpire]()
    var getUmpireHeader = [ "Authorization" : "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaGFudUBnbWFpbC5jb20iLCJleHAiOjE2NzIxMTEzOTEsImlhdCI6MTY3MjAyNDk5MX0.vWhcLFFUfZh70DbDIPnWrxuJmrBdt1NWln0glOTnD3c0Zek2RPVDccr1mq5WTyzSaEFv5P-zO2spUyyob12wsA","tournamentId" : "1"]
    
    var teams = [TeamInfo]()
    var getTeamdHeader = [ "Authorization" : "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaGFudUBnbWFpbC5jb20iLCJleHAiOjE2NzIxMTEzOTEsImlhdCI6MTY3MjAyNDk5MX0.vWhcLFFUfZh70DbDIPnWrxuJmrBdt1NWln0glOTnD3c0Zek2RPVDccr1mq5WTyzSaEFv5P-zO2spUyyob12wsA","tournamentId" : "1"]
    
    var getTeamHeader = [ "Authorization" : "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJkaGFudUBnbWFpbC5jb20iLCJleHAiOjE2NzIxMTEzOTEsImlhdCI6MTY3MjAyNDk5MX0.vWhcLFFUfZh70DbDIPnWrxuJmrBdt1NWln0glOTnD3c0Zek2RPVDccr1mq5WTyzSaEFv5P-zO2spUyyob12wsA","tournamentId" : "1"]
    var players = [PlayersInfo]()
    
    
    func getGrounds(completion: @escaping (Bool, Error?) -> Void) {
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/ground/view-all?pageSize=2&pageNumber=1"
        let queryUrl = URL(string: url)
        var allGrounds = [Ground]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: getGroundHeader) { (apidata, statusCode, error) in
            if let data = apidata {
                for ground in data {
                    let result = self.fetchGroundData(data: ground)
                    allGrounds.append(result)
                }
                self.grounds = allGrounds
                completion(true, nil)
            } else {
                print(error?.localizedDescription as Any)
                completion(false, error)
            }
        }
        }
    }
    
    func fetchGroundData(data: [String: Any]) -> Ground{
        var ground = Ground(id: Int64(0), tournamentId: Int64(0), groundName: "", city: "", groundLocation: "", latitude: 0.0, longitude: 0.0, groundPhoto: "", isSaved: true)
        
        if let currentGround = data["grounds"] as? [String: Any] {
            
            if let groundId = currentGround["groundId"] as? Int64 {
                ground.id = groundId
            }
            if let id = currentGround["tournamentId"] as? Int64 {
                ground.tournamentId = id
            }
            if let name = currentGround["groundName"] as? String {
                ground.groundName = name
            }
            if let city = currentGround["city"] as? String {
                ground.city = city
            }
            if let latitude = currentGround["latitude"] as? Double {
                ground.latitude = latitude
            }
            if let longitude = currentGround["longitude"] as? Double {
                ground.longitude = longitude
            }
        }
        return ground
    }
    
    func getUmpire(completion: @escaping ([Umpire]?, Error?) -> Void) {
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/umpire/view-all"
        let queryUrl = URL(string: url)
        var umpData = [Umpire]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: getUmpireHeader) { (apidata, statusCode, error) in
            if statusCode == 200 {
                if let data = apidata {
                    for element in data {
                        let umpire = self.fetchUmpireData(data: element)
                        umpData.append(umpire)
                    }
                    self.umpires = umpData
                    completion(umpData, nil)
                }
            } else {
                completion(nil, error)
            }
        }
        }
    }
    
    func fetchUmpireData(data: [String: Any]) -> Umpire {
        print(data)
        var umpire = Umpire(id: Int64(0), tournamentId: Int64(0), name: "", place: "", phone: "", isSaved: true, profile: "")
        if let id = data["umpireId"] as? Int64 {
            umpire.id = id
        }
        if let id = data["tournamentId"] as? Int64 {
            umpire.tournamentId = id
        }
        if let city = data["city"] as? String {
            umpire.place = city
        }
        if let phone = data["phoneNumber"] as? String {
            umpire.phone = phone
        }
        if let name = data["umpireName"] as? String {
            umpire.name = name
        }
        if let profile = data["umpirePhoto"] as? String {
            umpire.profile = profile
        }
        print(umpire)
        return umpire
    }
    
    func getTeamInfo(completion: @escaping ([TeamInfo]?, Error?) -> Void) {
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/team/view-all"
        let queryUrl = URL(string: url)
        var teamData = [TeamInfo]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: getTeamdHeader) { (apidata, statusCode, error) in
            if let data = apidata {
                teamData =  self.fetchTeamData(data: data)
                completion(teamData, nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        }
    }
    
    func fetchTeamData(data: [[String: Any]]) -> [TeamInfo] {
        if let data = data as? [[String: Any]]{
            
            var teamId = Int64(0)
            var tournamentId = Int64(0)
            var teamName = ""
            var captainName = ""
            var city = ""
            var numberOfPlayers = 0
            var totalMatchesPlayed = 0
            var totalWins = 0
            var totalLosses = 0
            var totalDrawOrCancelledOrNoResult = 0
            var points = 0
            var teamHighestScore = 0
            var netRunRate = 0.0
            var teamLogo = ""
            var teamStatus = ""
            var isDeleted = false
            
            for index in data {
                if let id = index["teamId"] as? Int64 {
                    teamId = id
                }
                
                if let id = index["tournamentId"] as? Int64 {
                    tournamentId = id
                }
                
                if let id = index["teamName"] as? String {
                    teamName = id
                }
                if let id = index["captainName"] as? String {
                    captainName = id
                }
                if let id = index["city"] as? String {
                    city = id
                }
                if let id = index["numberOfPlayers"] as? Int {
                    numberOfPlayers = id
                }
                if let id = index["totalMatchesPlayed"] as? Int {
                    totalMatchesPlayed = id
                }
                if let id = index["totalWins"] as? Int {
                    totalWins = id
                }
                if let id = index["totalLosses"] as? Int {
                    totalLosses = id
                }
                if let id = index["totalDrawOrCancelledOrNoResult"] as? Int {
                    totalDrawOrCancelledOrNoResult = id
                }
                if let id = index["points"] as? Int {
                    points = id
                }
                if let id = index["teamHighestScore"] as? Int {
                    teamHighestScore = id
                }
                if let id = index["netRunRate"] as? Double {
                    netRunRate = id
                }
                if let id = index["teamLogo"] as? String {
                    teamLogo = id
                }
                if let id = index["teamStatus"] as? String {
                    teamStatus = id
                }
                if let id = index["isDeleted"] as? Bool {
                    isDeleted = id
                }
                
                let  teamm = TeamInfo(teamId: Int64(teamId), tournamentId: tournamentId, teamName: teamName, captainName: captainName, city: city, numberOfPlayers: numberOfPlayers, totalMatchesPlayed: totalMatchesPlayed, totalWins: totalWins, totalLosses: totalLosses, totalDrawOrCancelledOrNoResult: totalDrawOrCancelledOrNoResult, points: points, teamHighestScore: teamHighestScore, netRunRate: netRunRate, teamLogo: teamLogo, teamStatus: teamStatus, isDeleted: isDeleted)
                self.teams.append(teamm)
            }
        }
        return teams
    }
    
    func getPlayerInfo(completion: @escaping ([PlayersInfo]?, Error?) -> Void) {
        let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/player/view"
        let queryUrl = URL(string: url)
        var teamData = [PlayersInfo]()
        if queryUrl != nil { network.getTournamentData(url: url, headers: getTeamdHeader) { (apidata, statusCode, error) in
            if let data = apidata {
                teamData =  self.fetchPlayerData(data: data)
                completion(teamData, nil)
            } else {
                print(error?.localizedDescription as Any)
            }
        }
        }
    }
    
    func fetchPlayerData(data: [[String: Any]]) -> [PlayersInfo] {
        if let data = data as? [[String: Any]]{
            
            var playerId = Int64(0)
            var tournamentId = Int64(0)
            var teamId = Int64(0)
            var playerName = ""
            var battingAverage = 0.0
            var battingStrikeRate = 0.0
            var totalFifties = 0
            var totalHundreds = 0
            var totalFours = 0
            var totalSixes = 0
            var mostWickets = 0
            var totalRuns = 0
            var bestBowlingAverage = 0.0
            var bestBowlingEconomy = 0.0
            var bestBowlingStrikeRate = 0.0
            var mostFiveWicketsHaul = 0
            
            for data in data {
                if let id = data["playerId"] as? Int64 {
                    playerId = id
                }
                if let id = data["tournamentId"] as? Int64 {
                    tournamentId = id
                }
                if let id = data["teamId"] as? Int64 {
                    teamId = id
                }
                
                if let id = data["playerName"] as? String {
                    playerName = id
                }
                
                if let id = data["battingAverage"] as? Double {
                    battingAverage = id
                }
                
                if let id = data["battingStrikeRate"] as? Double {
                    battingStrikeRate = id
                }
                if let id = data["totalFifties"] as? Int {
                    totalFifties = id
                }
                if let id = data["totalHundreds"] as? Int {
                    totalHundreds = id
                }
                if let id = data["totalFours"] as? Int {
                    totalFours = id
                }
                if let id = data["totalSixes"] as? Int {
                    totalSixes = id
                }
                if let id = data["mostWickets"] as? Int {
                    mostWickets = id
                }
                if let id = data["totalRuns"] as? Int {
                    totalRuns = id
                }
                if let id = data["bestBowlingAverage"] as? Double {
                    bestBowlingAverage = id
                }
                if let id = data["bestBowlingEconomy"] as? Double {
                    bestBowlingEconomy = id
                }
                if let id = data["bestBowlingStrikeRate"] as? Double {
                    bestBowlingStrikeRate = id
                }
                if let id = data["mostFiveWicketsHaul"] as? Int {
                    mostFiveWicketsHaul = id
                }
                
                
                let playeer = PlayersInfo(playerId:playerId, tournamentId:tournamentId, teamId:teamId, playerName: playerName, battingAverage: battingAverage, battingStrikeRate: battingStrikeRate, totalFifties: totalFifties, totalHundreds: totalHundreds, totalFours: totalFours, totalSixes: totalSixes, mostWickets: mostWickets, totalRuns: totalRuns, bestBowlingAverage: bestBowlingAverage, bestBowlingEconomy: bestBowlingEconomy, bestBowlingStrikeRate: bestBowlingStrikeRate, mostFiveWicketsHaul: mostFiveWicketsHaul)
                self.players.append(playeer)
            }
        }
        return players
    }
}
