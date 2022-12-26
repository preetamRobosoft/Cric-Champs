//
//  TournamentOverviewVC.swift
//  Cricket
//
//  Created by Preetam G on 12/12/22.
//

import UIKit

class TournamentOverviewVC: UIViewController {
    
    var tournamentViewModel = TournamentViewModel.shared
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var generateFixture: GradientButton!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var tournamentCode: UILabel!
    @IBOutlet weak var fixtureView: UIView!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var tryAgainOrViewButton: UIButton!
    @IBOutlet weak var generateFixtureResultIMage: UIImageView!
    
    @IBOutlet weak var resultMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        configure()
    }
    
    private func configure() {
        tableView.dataSource = self
        tableView.delegate = self
        self.generateFixture.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
        tournamentCode.layer.cornerRadius = 10
        tournamentCode.layer.masksToBounds = true
        fixtureView.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hideFixtureView()
        tournamentViewModel.fetchTournamentOverview{
            isSuccess, error in
            DispatchQueue.main.async {
                if isSuccess {
                    self.tableView.reloadData()
                    self.leagueName.text = self.tournamentViewModel.tournamentOverView?.tournamentName
                    self.tournamentCode.text = "Tournament Code:" +  (self.tournamentViewModel.tournamentOverView?.tournamentCode)!
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.generateFixture.setUpButtonBackGround(colours: [ #colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: 0)
    }
    private func registerCell() {
        tableView.register(UINib(nibName: "OverViewCell", bundle: nil), forCellReuseIdentifier: "overViewCell")
    }
    
    @IBAction func onClickGenerateFixture(_ sender: Any) {
        tournamentViewModel.makeGenerateFixtureRequest{ isSuccess, error in
            DispatchQueue.main.async {
                if isSuccess {
                    self.showFixtureView()
                    self.setUpSuccessFixtureGeneration()
                } else {
                    self.showFixtureView()
                    self.setUpFailureFixtureGeneration()
                }
            }
        }
    }
    
    @IBAction func onClickTapped(_ sender: Any) {
        if tournamentViewModel.isFixtureSuccessFull {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ManageViewController") as? ManageViewController
            guard  let manageVc = vc else {
                return
            }
            navigationController?.pushViewController(manageVc, animated: true)
        } else {
            hideFixtureView()
        }
    }
    
    private func showFixtureView() {
        fixtureView.isHidden = false
        transparentView.isHidden = false
    }
    
    private func hideFixtureView() {
        fixtureView.isHidden = true
        transparentView.isHidden = true
    }
    
    private func setUpSuccessFixtureGeneration() {
        tryAgainOrViewButton.setTitle("VIEW MATCHES", for: .normal)
        tryAgainOrViewButton.setTitleColor(#colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1), for: .normal)
        generateFixtureResultIMage.image = #imageLiteral(resourceName: "AwesomeBall")
        resultMessage.text = "Your Fixture has been generated!"
    }
    
    private func setUpFailureFixtureGeneration() {
        generateFixtureResultIMage.image = #imageLiteral(resourceName: "Oopsball")
        tryAgainOrViewButton.setTitle("TRY AGAIN", for: .normal)
        tryAgainOrViewButton.setTitleColor(#colorLiteral(red: 0.9607843137, green: 0.06666666667, blue: 0.1764705882, alpha: 1), for: .normal)
        resultMessage.text = "Oops! Something went wrong."
    }
    
}

extension TournamentOverviewVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return setDataforCell(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToViewController(index: indexPath.row)
    }
    
    private func setDataforCell(indexPath: IndexPath) -> UITableViewCell {
        guard let overView = tournamentViewModel.tournamentOverView else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "overViewCell") as? OverViewCell else {
            return UITableViewCell()
        }
        switch indexPath.row {
        
        case 0: cell.setData(string: "Teams", overview: String(overView.numberOfTeams ?? 0))
        case 1: cell.setData(string: "Overs", overview: String(overView.numberOfOvers ?? 0))
        case 2: cell.setData(string: "Grounds", overview: String(overView.numberOfGrounds ?? 0))
        case 3: cell.setData(string: "Umpires", overview: String(overView.numberOfUmpires ?? 0))
        case 4: cell.setData(string: "Start Date", overview: overView.tournamentStartDate ?? "")
        case 5: cell.setData(string: "End Date", overview: overView.tournamentEndDate ?? "")
        case 6: cell.setData(string: "Start Of Play", overview:  overView.tournamentStartTime ?? "")
        case 7: cell.setData(string: "End Of Play", overview: overView.tournamentEndTime ?? "")
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    private func navigateToViewController(index: Int) {
        switch index {
        case 0: let vc = storyboard?.instantiateViewController(withIdentifier: "AddTeamListViewController") as? AddTeamListViewController
            navigationController?.pushViewController(vc!, animated: true)
        case 1: let vc = storyboard?.instantiateViewController(withIdentifier: "OversViewController") as? OversViewController
            navigationController?.pushViewController(vc!, animated: true)
        case 2: let vc = storyboard?.instantiateViewController(withIdentifier: "GroundsViewController") as? GroundsViewController
            navigationController?.pushViewController(vc!, animated: true)
        case 3: let vc = storyboard?.instantiateViewController(withIdentifier: "UmpiresViewController") as? UmpiresViewController
            navigationController?.pushViewController(vc!, animated: true)
        case 4: let vc = storyboard?.instantiateViewController(withIdentifier: "CalenderVC") as? CalenderVC
            navigationController?.pushViewController(vc!, animated: true)
        case 5: let vc = storyboard?.instantiateViewController(withIdentifier: "CalenderVC") as? CalenderVC
            navigationController?.pushViewController(vc!, animated: true)
        case 6: let vc = storyboard?.instantiateViewController(withIdentifier: "ClockViewController") as? ClockViewController
            navigationController?.pushViewController(vc!, animated: true)
        case 7: let vc = storyboard?.instantiateViewController(withIdentifier: "ClockViewController") as? ClockViewController
            navigationController?.pushViewController(vc!, animated: true)
        default:
            alertAction(controller: self, message: "Error")
        }
    }
    
}
