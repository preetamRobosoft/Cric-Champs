//
//  AddPlayerViewController.swift
//  Cricket
//
//  Created by Preetam G on 12/12/22.
//

import UIKit

class AddPlayerViewController: UIViewController {
    
    var tournamentViewModel = TournamentViewModel.shared

    @IBOutlet weak var designationSwitch: UISwitch!
    @IBOutlet weak var captainButton: RadioButton!
    @IBOutlet weak var viceCaptainButton: RadioButton!
    @IBOutlet weak var battingButton: RadioButton!
    @IBOutlet weak var bowlingButton: RadioButton!
    @IBOutlet weak var allRounderButton: RadioButton!
    @IBOutlet weak var wicketKeeperButton: RadioButton!
    @IBOutlet weak var rightHandedBatting: RadioButton!
    @IBOutlet weak var rightHandedBowling: RadioButton!
    @IBOutlet weak var fastBowling: RadioButton!
    @IBOutlet weak var spinBowling: RadioButton!
    @IBOutlet weak var leftHandedBowling: RadioButton!
    @IBOutlet weak var leftHandedBatting: RadioButton!
    @IBOutlet weak var expertiseSwitch: UISwitch!
    @IBOutlet weak var battingSwitch: UISwitch!
    @IBOutlet weak var bowlingSwitch: UISwitch!
    @IBOutlet weak var bowlingTypeSwitch: UISwitch!
    @IBOutlet weak var triangleBackGround: TriangleView!
    @IBOutlet weak var profilePhoto: CustomImageView!
    @IBOutlet weak var profilePhotoBackGround: ProfilePhotoImageView!
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var cityname: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var savePlayer: GradientButton!
    
    var designation = ""
    var expertise = ""
    var batting = ""
    var bowling = ""
    var bowlingtype = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSwitch()
        setUpView()
        setUpButton()
    }
    
    private func setUpView() {
        profilePhoto.setCornerRadius()
        profilePhotoBackGround.setRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpSwitch()
        setUpView()
        setUpButton()
        if let player = tournamentViewModel.currentPlayer {
            setUpFeilds(player: player)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        savePlayer.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    private func setUpFeilds(player: Player) {
        playerName.text = player.name
        cityname.text = player.place
        phoneNumber.text = player.phone
    }
    
    private func setUpButton() {
        disableDesignationButtons()
        disableExpertiseButtons()
        disableBattingButtons()
        disableBowlingButtons()
        disableBowlingTypeButtons()
        savePlayer.setUpButtonBackGround(colours: [#colorLiteral(red: 1, green: 0.7294117647, blue: 0.5490196078, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.3607843137, blue: 0.4156862745, alpha: 1)], cornerRadius: CGFloat(0))
    }
    
    private func disableDesignationButtons() {
        captainButton.isEnabled = false
        viceCaptainButton.isEnabled = false
        captainButton.setDisabledBackGround()
        viceCaptainButton.setDisabledBackGround()
    }
    
    private func disableExpertiseButtons() {
        battingButton.isEnabled = false
        bowlingButton.isEnabled = false
        allRounderButton.isEnabled = false
        wicketKeeperButton.isEnabled = false
        battingButton.setDisabledBackGround()
        bowlingButton.setDisabledBackGround()
        allRounderButton.setDisabledBackGround()
        wicketKeeperButton.setDisabledBackGround()
    }
    
    private func disableBattingButtons() {
        rightHandedBatting.isEnabled = false
        leftHandedBatting.isEnabled = false
        rightHandedBatting.setDisabledBackGround()
        leftHandedBatting.setDisabledBackGround()
    }
    
    private func disableBowlingButtons() {
        rightHandedBowling.isEnabled = false
        leftHandedBowling.isEnabled = false
        leftHandedBowling.setDisabledBackGround()
        rightHandedBowling.setDisabledBackGround()
    }
    
    private func disableBowlingTypeButtons() {
        spinBowling.isEnabled = false
        fastBowling.isEnabled = false
        spinBowling.setDisabledBackGround()
        fastBowling.setDisabledBackGround()
    }

    private func enableDesignationButtons() {
        captainButton.isEnabled = true
        viceCaptainButton.isEnabled = true
        captainButton.configure()
        viceCaptainButton.configure()
    }
    
    private func enableExpertiseButtons() {
        battingButton.isEnabled = true
        bowlingButton.isEnabled = true
        allRounderButton.isEnabled = true
        wicketKeeperButton.isEnabled = true
        battingButton.configure()
        bowlingButton.configure()
        allRounderButton.configure()
        wicketKeeperButton.configure()
    }
    
    private func enableBattingButtons() {
        rightHandedBatting.isEnabled = true
        leftHandedBatting.isEnabled = true
        rightHandedBatting.configure()
        leftHandedBatting.configure()
    }
    
    private func enableBowlingButtons() {
        rightHandedBowling.isEnabled = true
        leftHandedBowling.isEnabled = true
        leftHandedBowling.configure()
        rightHandedBowling.configure()
    }
    
    private func enableBowlingTypeButtons() {
        spinBowling.isEnabled = true
        fastBowling.isEnabled = true
        spinBowling.configure()
        fastBowling.configure()
    }
    
    private func disableBowlingSwitch() {
        bowlingSwitch.setOn(false, animated: true)
        bowlingTypeSwitch.setOn(false, animated: true)
        bowlingSwitch.isUserInteractionEnabled = false
        bowlingTypeSwitch.isUserInteractionEnabled = false
    }
    private func enableBowlingSwitch() {
        bowlingSwitch.setOn(false, animated: true)
        bowlingTypeSwitch.setOn(false, animated: true)
        bowlingSwitch.isUserInteractionEnabled = true
        bowlingTypeSwitch.isUserInteractionEnabled = true
    }
    private func setUpSwitch() {
        designationSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        expertiseSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        bowlingSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        battingSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        bowlingTypeSwitch.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        
        designationSwitch.setOn(false, animated: true)
        expertiseSwitch.setOn(false, animated: true)
        battingSwitch.setOn(false, animated: true)
        bowlingSwitch.setOn(false, animated: true)
        bowlingTypeSwitch.setOn(false, animated: true)
        
        bowlingTypeSwitch.isUserInteractionEnabled = true
    }
    
    @IBAction func onSelectDesignation(_ sender: Any) {
        if designationSwitch.isOn {
            enableDesignationButtons()
        } else {
            designation = ""
            disableDesignationButtons()
        }
    }
    
    @IBAction func onSelectDesignationName(_ sender: RadioButton) {
        sender.changeButtonsStatus(sender: sender, buttons: [captainButton, viceCaptainButton])
        if let title = sender.titleLabel?.text {
            designation = title.replacingOccurrences(of: " ", with: "")
        }
    }
 
    @IBAction func onSelectExpertise(_ sender: Any) {
        if expertiseSwitch.isOn {
            enableExpertiseButtons()
        } else {
            disableExpertiseButtons()
            expertise = ""
        }
    }
    
    @IBAction func onClickExpertiseType(_ sender: RadioButton) {
        sender.changeButtonsStatus(sender: sender, buttons: [battingButton, bowlingButton, allRounderButton, wicketKeeperButton])
        if let title = sender.titleLabel?.text {
            expertise = title.replacingOccurrences(of: " ", with: "")
        }
    }
    
    @IBAction func onSelectBatting(_ sender: Any) {
        if battingSwitch.isOn {
            enableBattingButtons()
        } else {
            disableBattingButtons()
            batting = ""
        }
    }
    @IBAction func onClickBattingType(_ sender: RadioButton) {
        sender.changeButtonsStatus(sender: sender, buttons: [rightHandedBatting, leftHandedBatting])
        if let title = sender.titleLabel?.text {
            batting = title.replacingOccurrences(of: " ", with: "")
        }
    }
    
    @IBAction func onSelectBowling(_ sender: Any) {
        if bowlingSwitch.isOn {
            enableBowlingButtons()
            enableBowlingTypeButtons()
            bowlingTypeSwitch.isUserInteractionEnabled = true
            bowlingTypeSwitch.setOn(true, animated: true)
        } else {
            disableBowlingButtons()
            disableBowlingTypeButtons()
            bowlingTypeSwitch.setOn(false, animated: true)
            bowlingTypeSwitch.isUserInteractionEnabled = false
            bowling = ""
        }
    }
    
    @IBAction func onClickBowling(_ sender: RadioButton) {
        sender.changeButtonsStatus(sender: sender, buttons: [rightHandedBowling, leftHandedBowling])
        if let title = sender.titleLabel?.text {
            bowling = title.replacingOccurrences(of: " ", with: "")
        }
    }
    
    @IBAction func onSelectBowlingType(_ sender: Any) {
        if bowlingTypeSwitch.isOn {
            enableBowlingTypeButtons()
        } else {
            disableBowlingTypeButtons()
            bowlingtype = ""
        }
    }
    
    @IBAction func onClickBowlingType(_ sender: RadioButton) {
        sender.changeButtonsStatus(sender: sender, buttons: [spinBowling, fastBowling])
        if let title = sender.titleLabel?.text {
            bowlingtype = title.replacingOccurrences(of: " ", with: "")
        }
    }
    
    @IBAction func onClickSelectPhoto(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    @IBAction func onClickSavePlayer(_ sender: Any) {
        if validateFields() {
            let player = Player(name: playerName.text ?? "Player", place: cityname.text ?? "", phone: phoneNumber.text ?? "", designation: designation, expertise: expertise, batting: batting, bowling: bowling, bowlingType: bowlingtype, profilePhoto: profilePhoto.image)
            tournamentViewModel.currentPlayer = player
            tournamentViewModel.savePlayer { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.clearAllFields()
                    } else {
                        alertAction(controller: self, message: error!.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    private func validateFields() -> Bool {
        var isValid = true
        if profilePhoto.image == nil {
            isValid = false
            alertAction(controller: self, message: "Select Profile Photo")
        }
        if playerName.text == "" {
            isValid = false
            alertAction(controller: self, message: "Enter Team Name")
        }
        if cityname.text == "" {
            isValid = false
            alertAction(controller: self, message: "Enter City Name")
        }
        return isValid
    }
    
    private func clearAllFields() {
        self.designation = ""
        self.expertise = ""
        self.batting = ""
        self.bowling = ""
        self.bowlingtype = ""
        setUpSwitch()
        setUpButton()
        playerName.text = ""
        profilePhoto.image = nil
        phoneNumber.text = ""
        cityname.text = ""
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        tournamentViewModel.currentPlayer = nil
        tournamentViewModel.players = []
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddPlayerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let fetchedImage = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage
        profilePhoto.image = fetchedImage
        picker.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
