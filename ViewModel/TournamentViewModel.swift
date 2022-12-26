//
//  CreateTournamentViewModel.swift
//  Cricket
//
//  Created by Dhanush Devadiga on 07/12/22.
//

import Foundation
import UIKit

class TournamentViewModel {
    
    static var shared = TournamentViewModel()
    var homeVM = HomeViewModel.shared
    
    func sendID() -> Int64 {
        return tournamentDetails!.id
    }
    
    func getToken() -> String? {
        if let token = homeVM.user?.authorization {
            return token
        } else {
            return nil
        }
    }
    
    //Tournament
    var tournamentLogo: UIImage?
    var isTournamentSelected = false
    var minimumNumberOfTeams = 0
    var isIndividualMatch = false
    let url = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/tournament/create"
    var parameterForCreateTournament = ["tournamentType":"", "tournamentName": ""]
    var header = ["Authorization": ""]
    var tournamentDetails: Tournament?
    
    //Team
    var teams: [Team] = []
    var players = [Player]()
    var currentTeam: Team?
    var teamLogo: UIImage?
    let urlCreateTeam = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/team/create"
    var parameterForAddteam = ["tournamentId":"", "teamName": "", "city" : ""]
    let getTeamsUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/team/view-all"
    var headerForGetTeams = ["tournamentId": ""]
    
    //Player
    var currentPlayer: Player?
    var playerProfile: UIImage?
    let addPlayerUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/player/register"
    var parametersForSavePlayer = ["tournamentId": "", "teamId": "", "playerName": "", "city": "", "phoneNumber": "", "designation": "", "expertise": "", "battingStyle": "", "bowlingStyle": "", "bowlingType":""]
    let getPlayersUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/player/view-all"
    var headerForGetPlayers = ["tournamentId": "", "teamId": ""]
    
    //Over
    let overUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/tournament/set-overs"
    var headerForOver = ["Authorizarion": "", "tournamentId" : "", "numberOfOvers": ""]
    var numberOfOver: Int?
    
    //Ground
    let addGroundUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/ground/add"
    let getGroundUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/ground/view-all?pageSize=10&pageNumber=1"
    var parameterForAddGround = ["tournamentId": "", "groundName": "", "city" : "","groundLocation":"", "latitude" : "", "longitude": ""] as [String: Any]
    var currentGround: Ground?
    var grounds = [Ground]()
    var groundImage: UIImage?
    var headerForGetGrounds = ["Authorizarion": "", "tournamentId": ""]
    
    //Umpire
    var currentUmpire: Umpire?
    var umpires = [Umpire]()
    let addUmpireUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/umpire/add"
    var parameterForAddUmpire = ["tournamentId": "", "umpireName": "", "city" : "", "phoneNumber":""]
    let getUmpireUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/umpire/view-all?pageSize=2&pageNumber=1"
    var headerForGetUmpire = ["tournamentId": ""]
    
    //OverView
    var tournamentOverView: TournamentOverView?
    let overViewUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/tournament/view"
    var overViewHeader = ["tournamentId": "", "Authorization": ""]

    //GenerateFixture
    let generateFixtureUrl = "http://cric-env.eba-esrqeiw3.ap-south-1.elasticbeanstalk.com/fixture/generate"
    var generateFixtureHeader = ["tournamentId": "", "Authorization": ""]
    var isFixtureSuccessFull = false
    
    private func setHeader() {
        header["Authorization"] = homeVM.user?.authorization
    }
    

    func createTournament(completion: @escaping((Tournament?, Error?) -> Void)) {
        self.setHeader() 
        let networkManger = NetworkManager()
        networkManger.postData(url: url, parameters: parameterForCreateTournament, headers: header, image: tournamentLogo, imageFieldName: "logo") { (response, data, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            if response.statusCode == 200 {
                if let data = data as? [String: Any]{
                    let name = data["tournamentName"] as? String
                    let code = data["tournamentCode"] as? String
                    let id = data["tournamentId"] as? Int64
                    let tournament = Tournament(id: id ?? Int64(0), name: name ?? "", tournamentCode: code ?? "")
                    self.tournamentDetails = tournament
                    completion(tournament, nil)
                }
            }
        }
    }
    
    func setParameterForCreateTournament(tournamentType: String, tournamentName: String) {
        parameterForCreateTournament["tournamentType"] = tournamentType.uppercased().replacingOccurrences(of: " ", with: "")
        parameterForCreateTournament["tournamentName"] = tournamentName.capitalized
        let type = tournamentType.uppercased().replacingOccurrences(of: " ", with: "")
        switch type {
        case "LEAGUE": minimumNumberOfTeams = 3
        case "INDIVIDUALMATCH": minimumNumberOfTeams = 2
                                isIndividualMatch = true
        case "KNOCKOUT": minimumNumberOfTeams = 2
        default:
            minimumNumberOfTeams = 0
        }
    }
    

    func saveTeam(completion: @escaping((Bool, Error?) -> Void)) {
        self.setHeader()
        self.setParameterForCreateTeam()
        if let image = currentTeam?.logo as? UIImage {
            teamLogo = image
        }
        let networkManger = NetworkManager()
        networkManger.postData(url: urlCreateTeam, parameters: parameterForAddteam, headers: header, image: teamLogo, imageFieldName: "teamPhoto" ) { (response, data, error) in
            if response.statusCode == 200 {
                if let data = data as? [String: Any]{
                    var team = self.fetchTeamDetails(data: data)
                    team.place = self.currentTeam?.place
                    team.logo = self.currentTeam?.logo
                    self.currentTeam = team
                }
                completion(true, nil)
            }
            if error != nil {
                completion(false, error)
            }
        }
    }
    
    func setParameterForCreateTeam() {
        if let team = currentTeam {
            parameterForAddteam["city"] = team.place
            parameterForAddteam["teamName"] = team.name
            parameterForAddteam["tournamentId"] = String(tournamentDetails!.id)
        }
    }
    
    func fetchTeam(completion: @escaping((Bool, Error?) -> Void)) {
        setHeaderForGetTeam()
        let networkManager = NetworkManager()
        var allTeams = [Team]()
        networkManager.getTournamentData(url: getTeamsUrl, headers: headerForGetTeams) {data, response, error in
            if response == 200 {
                if let data = data {
                    for team in data {
                        let team = self.fetchTeamDetails(data: team)
                        allTeams.append(team)
                    }
                    self.teams = allTeams
                    completion(true, nil)
                }
            } else {
                completion(false, error)
            }
        }
        
    }
    
    private func setHeaderForGetTeam() {
        headerForGetTeams["tournamentId"] = String(tournamentDetails!.id)
    }
    
    private func fetchTeamDetails(data: [String: Any]) -> Team {

        var team = Team(id: Int64(0), name: "", place: "", logo: "", isSaved: true)
        if let teamName = data["teamName"] as? String {
            team.name = teamName
        }
        if let imageUrl = data["teamLogo"] as? String {
            team.logo = imageUrl
        }
        if let id = data["teamId"] as? Int64 {
            team.id = id
        }
        if let city = data["city"] as? String {
            team.place = city
        }
        return team
    }
    
    func savePlayer(completion: @escaping((Bool, Error?) -> Void)) {
        self.setHeader()
        self.setParameterForSavePlayer()
        if let image = currentPlayer?.profilePhoto as? UIImage {
            playerProfile = image
        }
        let networkManger = NetworkManager()
        networkManger.postData(url: addPlayerUrl, parameters: parametersForSavePlayer, headers: header, image: playerProfile, imageFieldName: "playerPhoto" ) { (response, data, error) in
            if response.statusCode == 200 {
                if data != nil {
                    self.currentPlayer?.isSaved  = true
                }
                completion(true, nil)
            }
            if error != nil {
                completion(false, error)
            }
        }
    }
    
    private func setParameterForSavePlayer() {
        parametersForSavePlayer["tournamentId"] = String(tournamentDetails!.id)
        if let player = currentPlayer {
            parametersForSavePlayer["teamId"] = String(currentTeam!.id)
            parametersForSavePlayer["playerName"] = player.name
            parametersForSavePlayer["city"] = player.place
            parametersForSavePlayer["phoneNumber"] = player.phone
            if player.designation == "" {
                parametersForSavePlayer["designation"] = nil
            } else {
                parametersForSavePlayer["designation"] = player.designation
            }
            parametersForSavePlayer["expertise"] = player.expertise
            parametersForSavePlayer["battingStyle"] = player.batting
            parametersForSavePlayer["bowlingStyle"] = player.bowling
            parametersForSavePlayer["bowlingType"] = player.bowlingType
        }
    }
    
    func fetchPlayers(completion: @escaping((Bool, Error?) -> Void)) {
        setHeaderForGetPlayer()
        var allPlayers = [Player]()
        if headerForGetPlayers["teamId"] == "" {
            completion(true, nil)
        } else {
            let networkManager = NetworkManager()
            networkManager.getTournamentData(url: getPlayersUrl, headers: headerForGetPlayers) {data, response, error in
                if response == 200 {
                    if let data = data {
                        for player in data {
                            let player = self.fetchPlayerDetails(data: player)
                            allPlayers.append(player)
                        }
                        self.players = allPlayers
                        completion(true, nil)
                    }
                } else {
                    completion(false, error)
                }
            }
        }
    }
    
    private func setHeaderForGetPlayer() {
        headerForGetPlayers["tournamentId"] = String(tournamentDetails!.id)
        if let team = currentTeam {
            headerForGetPlayers["teamId"] = String(team.id)
        }
    }
    
    private func fetchPlayerDetails(data: [String: Any]) -> Player {
        
        var player = Player(teamId: Int64(0), name: "", place: "", phone: "", designation: "", expertise: "", batting: "", bowling: "", bowlingType: "", profilePhoto: "", isSaved: true)
        
        if let id = data["teamId"] as? Int64 {
            player.teamId = id
        }
        if let playerName = data["playerName"] as? String {
            player.name = playerName
        }
        if let city = data["city"] as? String {
            player.place = city
        }
        if let phoneNumber = data["phoneNumber"] as? String {
            player.phone = phoneNumber
        }
        if let designationData = data["designation"] as? String {
            player.designation = designationData
        }
        if let expertiseData = data["expertise"] as? String {
            player.expertise = expertiseData
        }
        if let battingStyleData = data["battingStyle"] as? String {
            player.batting = battingStyleData
        }
        if let bowlingStyleData = data["bowlingStyle"] as? String {
            player.bowling = bowlingStyleData
        }
        if let bowlingTypeData = data["bowlingType"] as? String {
            player.bowlingType = bowlingTypeData
        }
        if let playerPhoto = data["profilePhoto"] as? String {
            player.profilePhoto = playerPhoto
        }

        return player
    }
    
    func setOver(over: Int, completion: @escaping((Bool, Error?) -> Void)) {
        self.setHeaderForOver(over: over)
        let networkManger = NetworkManager()
        networkManger.patchData(url: overUrl, parameters: ["":""], headers: headerForOver, image: nil) { statusCode, error in
            if statusCode == 200 {
                self.numberOfOver = over
                completion(true, nil)
            }
            if error != nil {
                completion(false, error)
            }
        }
    }
    
    private func setHeaderForOver(over: Int) {
        headerForOver["Authorization"] = homeVM.user?.authorization
        headerForOver["tournamentId"] = String(tournamentDetails!.id)
        headerForOver["numberOfOvers"] = String(over)
    }
    
    func addGround(completion: @escaping((Bool, String?, Error?) -> Void)) {
        self.setHeaderForAddGround()
        self.setHeader()

        if let image = currentGround?.groundPhoto as? UIImage {
            groundImage = image
        }
        let networkManger = NetworkManager()
        networkManger.postData(url: addGroundUrl, parameters: parameterForAddGround, headers: header, image: nil, imageFieldName: "groundPhoto" ) { (response, data, error) in
            if response.statusCode == 200 {
                if let data = data as? [String: Any]{
                    self.currentGround?.isSaved = true
                    completion(true, data["message"] as? String, nil)
                }
            }
            if error != nil {
                completion(false, nil, error)
            }
        }
       
    }
    
    private func setHeaderForAddGround() {
        parameterForAddGround["tournamentId"] = String(tournamentDetails!.id)
        if let ground = currentGround {
            parameterForAddGround["groundName"] = ground.groundName
            parameterForAddGround["city"] = ground.city
            parameterForAddGround["groundLocation"] = ground.city
            parameterForAddGround["latitude"] = ground.latitude
            parameterForAddGround["longitude"] = ground.longitude
        }
    }
    
    func fetchGrounds(completion: @escaping((Bool, Error?) -> Void)) {
        setHeaderForGetGround()
        var allGrounds = [Ground]()
        let networkManager = NetworkManager()
        networkManager.getTournamentData(url: getGroundUrl, headers: headerForGetGrounds) {data, response, error in
            if response == 200 {
                if let data = data {
                    for ground in data {
                        let result = self.fetchGroundDetails(data: ground)
                        allGrounds.append(result)
                    }
                    self.grounds = allGrounds
                    completion(true, nil)
                }
            } else {
                completion(false, error)
            }
        }
        
    }
    
    private func setHeaderForGetGround() {
        headerForGetGrounds["Authorization"] = homeVM.user?.authorization
        headerForGetGrounds["tournamentId"] = String(tournamentDetails!.id)
    }
    
    private func fetchGroundDetails(data: [String: Any]) -> Ground {
        
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
    
    func saveUmpire(completion: @escaping((Bool, Error?) -> Void)) {
        self.setHeader()
        self.setParameterForAddUmpire()
        var umpireProfile:  UIImage?
        if let image = currentUmpire?.profile as? UIImage {
            umpireProfile = image
        }
        let networkManger = NetworkManager()
        networkManger.postData(url: addUmpireUrl, parameters: parameterForAddUmpire, headers: header, image: umpireProfile, imageFieldName: "profilePhoto" ) { (response, data, error) in
            if response.statusCode == 200 {
                if let data = data {
                    let umpire = self.fetchUmpireDetails(data: data as! [String : Any])
                    self.currentUmpire = umpire
                }
                completion(true, nil)
            }
            if error != nil {
                completion(false, error)
            }
        }
    }
    
    func setParameterForAddUmpire() {
        if let umpire = currentUmpire {
            parameterForAddUmpire["city"] = umpire.place
            parameterForAddUmpire["umpireName"] = umpire.name
            parameterForAddUmpire["tournamentId"] = String(tournamentDetails!.id)
            parameterForAddUmpire["phoneNumber"] = umpire.phone
        }
    }
    
    func fetchUmpire(completion: @escaping((Bool, Error?) -> Void)) {
        setHeaderForGetGround()
        let networkManager = NetworkManager()
        var allUmpire = [Umpire]()
        networkManager.getTournamentData(url: getUmpireUrl, headers: headerForGetGrounds) {data, response, error in
            if response == 200 {
                if let data = data {
                    for element in data {
                        let umpire = self.fetchUmpireDetails(data: element)
                        allUmpire.append(umpire)
                    }
                    self.umpires = allUmpire
                    completion(true, nil)
                }
            } else {
                completion(false, error)
            }
        }
        
    }
    
    private func setHeaderForGetUmpire() {
        headerForGetUmpire["Authorization"] = String((homeVM.user?.authorization)!)
        headerForGetUmpire["tournamentId"] = String(tournamentDetails!.id)
    }
    
    private func fetchUmpireDetails(data: [String: Any]) -> Umpire {

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
        return umpire
    }
    
    func fetchTournamentOverview(completion: @escaping((Bool, Error?) -> Void)) {
        let networkManager = NetworkManager()
        setHeaderForGetTournamentOverView()
        networkManager.getTournamentOverViewData(url: overViewUrl, headers: overViewHeader) {data, response, error in
            if response == 200 {
                if let data = data {
                    let overView = self.fetchTournamentOverViewDetails(data: data)
                    self.tournamentOverView = overView
                    completion(true, nil)
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    private func setHeaderForGetTournamentOverView() {
        overViewHeader["Authorization"] = String((homeVM.user?.authorization)!)
        overViewHeader["tournamentId"] = String(tournamentDetails!.id)
    }
    
    private func fetchTournamentOverViewDetails(data: [String: Any]) -> TournamentOverView {
        var tournamentOverView = TournamentOverView()
        
        if let id = data["tournamentId"] as? Int64 {
            tournamentOverView.tournamentId = id
        }
        if let name = data["tournamentName"] as? String {
            tournamentOverView.tournamentName = name
        }
        if let code = data["tournamentCode"] as? String {
            tournamentOverView.tournamentCode = code
        }
        if let date = data["tournamentStartDate"] as? String {
            tournamentOverView.tournamentStartDate = getDate(date: date)
        }
        if let date = data["tournamentEndDate"] as? String {
            tournamentOverView.tournamentEndDate = getDate(date: date)
        }
        if let time = data["tournamentStartTime"] as? String {
            tournamentOverView.tournamentStartTime = getTime(time: time)
        }
        if let time = data["tournamentEndTime"] as? String {
            tournamentOverView.tournamentEndTime = getTime(time: time)
        }
        if let teams = data["numberOfTeams"] as? Int {
            tournamentOverView.numberOfTeams = teams
        }
        if let overs = data["numberOfOvers"] as? Int {
            tournamentOverView.numberOfOvers = overs
        }
        if let grounds = data["numberOfGrounds"] as? Int {
            tournamentOverView.numberOfGrounds = grounds
        }
        if let umpires = data["numberOfUmpires"] as? Int {
            tournamentOverView.numberOfUmpires = umpires
        }
        if let status = data["tournamentStatus"] as? String {
            tournamentOverView.tournamentStatus = status
        }
        return tournamentOverView
    }
    
    
    private func getDate(date: String) -> String {
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let data = format.date(from: date)
        format.timeStyle = .short
        format.dateStyle = .medium
        format.dateFormat = "MMM dd yyyy"
        let dateValue = format.string(from: data!)
        let weekday = Calendar.current.component(.weekday, from: data!)
        let day = getWeekDay(weekDay: weekday)
        return day + ", " + dateValue
    }
    
    private func getTime(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "h:mm a"
        let convertedTime = dateFormatter.string(from: date!)
        return convertedTime
    }
    
    private func getWeekDay(weekDay: Int) -> String {
        switch  weekDay{
        case 1: return "Sun"
        case 2: return "Mon"
        case 3: return "Tue"
        case 4: return "Wed"
        case 5: return "Thu"
        case 6: return "Fri"
        case 7: return "Sat"
        default:
            return ""
        }
    }
    
    func makeGenerateFixtureRequest(completion: @escaping((Bool, Error?) -> Void)) {
        setHeaderForGenerateFixture()
        print("HEADER FOR GENERATE FIXTURE", header)
        let networkManager = NetworkManager()
        networkManager.postData(url: generateFixtureUrl, parameters: [:], headers: generateFixtureHeader, image: nil, imageFieldName: nil) {response, data, error in
            if response.statusCode == 200 {
                self.isFixtureSuccessFull = true
                if data != nil {
                    completion(true, nil)
                }
            } else {
                completion(false, error)
            }
        }
    }
    
    private func setHeaderForGenerateFixture() {
        generateFixtureHeader["Authorization"] = String((homeVM.user?.authorization)!)
        generateFixtureHeader["tournamentId"] = String(tournamentDetails!.id)
    }
}



