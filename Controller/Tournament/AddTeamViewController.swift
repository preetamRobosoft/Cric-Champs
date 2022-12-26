//
//  AddTeamViewController.swift
//  Cricket
//
//  Created by Preetam G on 09/12/22.
//

import UIKit

class AddTeamViewController: UIViewController {
    
    var tournamentViewModel = TournamentViewModel.shared
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var teamImageView: ProfilePhotoImageView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var teamImage: CustomImageView!
    @IBOutlet weak var teamName: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var saveTeam: GradientButton!
    @IBOutlet weak var cameraIcon: UIButton!
    @IBOutlet weak var addPlayer: CustomButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUptableView()
        setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tournamentViewModel.fetchPlayers{ success, error in
            DispatchQueue.main.async {
                if success {
                    self.tableView.reloadData()
                }
            }
        }
        if let  team = tournamentViewModel.currentTeam {
            setDataForFields(team: team)
        }
    }
    
    private func setDataForFields(team: Team) {
        teamName.text = team.name
        city.text = team.place
        guard  let imageUrl = URL(string: (team.logo as? String) ?? "" ) else {
            return
        }
        guard  let imageData = try? Data(contentsOf: imageUrl) else {
            return
        }
        teamImage.image = UIImage(data: imageData)
    }

    private func setUptableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EmptyDataCell", bundle: nil), forCellReuseIdentifier: "emptyDataCell")
        tableView.register(UINib(nibName: "GroundAndPlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerAndGround")
    }
    
    private func setUpView() {
        saveTeam.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
        setScrollViewHeight()
        teamImageView.setRadius()
        teamImage.setCornerRadius()
        if tournamentViewModel.currentTeam == nil {
            addPlayer.setUpButton(color: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), cornerRadius: addPlayer.bounds.height / 2)
            addPlayer.isEnabled = false
        } else {
            addPlayer.setUpButton(color: #colorLiteral(red: 0, green: 0.4, blue: 0.8862745098, alpha: 1), cornerRadius: addPlayer.bounds.height / 2)
            addPlayer.isEnabled = true
        }
    }
    
    private func disableField() {
        teamName.isUserInteractionEnabled = false
        city.isUserInteractionEnabled = false
        cameraIcon.isUserInteractionEnabled = false
    }

    func setScrollViewHeight() {
        let height = UIScreen.main.bounds.height
        
        if height > contentViewHeight.constant {
            contentViewHeight.constant = height
        }
    }
    
    @IBAction func onClickCamera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    @IBAction func onClickback(_ sender: Any) {
        tournamentViewModel.currentTeam = nil
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickSaveTeam(_ sender: Any) {
        if validateFields() {
            let team = Team(id: Int64(Int(0)), name: teamName.text!.trimmingCharacters(in: .whitespacesAndNewlines), place: city.text!.trimmingCharacters(in: .whitespacesAndNewlines), logo: teamImage.image, isSaved: false)
            if let currentTeam = tournamentViewModel.currentTeam {
                if currentTeam.isSaved == true {
                    tournamentViewModel.currentTeam = nil
                    navigationController?.popViewController(animated: true)
                }
            } else {
                tournamentViewModel.currentTeam = team
                tournamentViewModel.saveTeam { success, error in
                    DispatchQueue.main.async {
                        if success {
                            self.setUpView()
                            self.disableField()
                            self.tableView.reloadData()
                        } else {
                            alertAction(controller: self, message: error!.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func onClickAddPlayer(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddPlayerViewController") as? AddPlayerViewController
        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    private func validateFields() -> Bool {
        var isValid = true
        if teamImage.image == nil {
            isValid = false
            alertAction(controller: self, message: "Select Team Logo")
        }
        if teamName.text == "" {
            alertAction(controller: self, message: "Enter Team Name")
        }
        if city.text == "" {
            alertAction(controller: self, message: "Enter City Name")
        }
        return isValid
    }
    
}

extension AddTeamViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fetchedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        teamImage.image = fetchedImage
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension AddTeamViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tournamentViewModel.players.count == 0 {
            return 1
        }
        else {
            return tournamentViewModel.players.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tournamentViewModel.players.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyDataCell") as? EmptyDataCell
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "playerAndGround") as! GroundAndPlayerTableViewCell
            cell.setData(data: tournamentViewModel.players[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tournamentViewModel.players.count > 0 {
            let vc = storyboard?.instantiateViewController(identifier: "AddPlayerViewController") as? AddPlayerViewController
            tournamentViewModel.currentPlayer = tournamentViewModel.players[indexPath.row]
            navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    
}
