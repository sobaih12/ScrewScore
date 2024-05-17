//
//  ViewController.swift
//  Screw Score
//
//  Created by Mostfa Sobaih on 26/04/2024.
//

import UIKit

protocol PlayerSaverDelegate: AnyObject {
    func savePlayers()
}

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,PlayerSaverDelegate{
    
    @IBOutlet weak var scoreSegmentedOutlet: UISegmentedControl!
    @IBOutlet weak var plusFifteenOutlet: UIButton!
    @IBOutlet weak var plusTenOutlet: UIButton!
    @IBOutlet weak var plusFiveOutlet: UIButton!
    @IBOutlet weak var scoreTextField: UITextField!
    @IBOutlet weak var scoreEditorLabel: UILabel!
    @IBOutlet weak var EditorTextField: UITextField!
    @IBOutlet weak var customAlertView: UIView!
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var scoreEditor: UIView!
    @IBOutlet weak var customPlayerAdding: UIView!
    

    @IBOutlet weak var newPlayerTextField: UITextField!
    
    var playersList : [PlayerModel] = []
    var selectedPlayerIndex : Int = 0
    var isPlus : Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customAlertView.isHidden = true
        scoreEditor.isHidden = true
        customPlayerAdding.isHidden = true
        scoreTextField.layer.borderColor = UIColor.yellow.cgColor
        scoreTextField.layer.borderWidth = 1
        scoreTextField.layer.cornerRadius = 5.0
        scoreTextField.keyboardType = .numberPad
        
        playersList = CDHelper.shared.fetchDataFromCoreData()
    }
    
    func savePlayers() {
        print("willDisappear")
        CDHelper.shared.deleteAllPlayers()
        for player in playersList {
            print("beforeSaving")
            CDHelper.shared.saveDataToCoreData(player: player)
            print("afterSaving")
            
        }
    }
    
    @IBAction func EditorCancelBtn(_ sender: Any) {
        EditorTextField.text = ""
        customAlertView.isHidden = true
    }
    
    @IBAction func EditorSaveBtn(_ sender: Any) {
        playersList[selectedPlayerIndex].playerName = EditorTextField.text
        self.playersTableView.reloadData()
        EditorTextField.text = ""
        customAlertView.isHidden = true
    }
    @IBAction func settings(_ sender: Any) {
        
    }
    
    @IBAction func addingNewPlayer(_ sender: Any) {
        customPlayerAdding.isHidden = false
//        let alert = UIAlertController(title: "Add Player", message: "Enter Player Name : ", preferredStyle: .alert)
//        alert.addTextField()
//        let ffield = alert.textFields?.first
//        let yesAction = UIAlertAction(title: "yes", style: .default){
//            _ in
//            CDHelper.shared.deleteAllPlayers()
//            for player in self.playersList {
//                CDHelper.shared.saveDataToCoreData(player: player)
//            }
//            let player = PlayerModel(playerName:ffield?.text,playerScore: 0 , playerColor: Utils.colorArray.randomElement() ?? UIColor.magenta)
//            CDHelper.shared.saveDataToCoreData(player: player)
//            self.playersList = CDHelper.shared.fetchDataFromCoreData()
//            self.playersTableView.reloadData()
//        }
//        let action = UIAlertAction(title: "no", style: .destructive)
//        alert.addAction(yesAction)
//        alert.addAction(action)
//        present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(playersList.count)
        return playersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! PlayerCustomCell
        let selectedPlayer = playersList[indexPath.row]
        
        cell.playerNameText.text = selectedPlayer.playerName
        cell.scoreText.text = "\(selectedPlayer.playerScore)"
        cell.incrementPlayerScore = {
            self.playersList[indexPath.row].playerScore += 1
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        cell.changePlayerColor = {
            self.playersList[indexPath.row].playerColor = cell.colorWell.selectedColor ?? UIColor.red
        }
        cell.changePlayerName = {
            self.customAlertView.isHidden = false
            self.selectedPlayerIndex = indexPath.row
            self.EditorTextField.placeholder = self.playersList[indexPath.row].playerName
            
        }
        cell.changePlayerScore = {
            self.scoreEditor.isHidden = false
            self.selectedPlayerIndex = indexPath.row
            self.scoreEditorLabel.text = self.playersList[indexPath.row].playerScore.description
            self.scoreEditorLabel.backgroundColor = self.playersList[indexPath.row].playerColor
            self.scoreSegmentedOutlet.selectedSegmentIndex = 0
            
            
            
        }
        cell.colorWell.selectedColor = selectedPlayer.playerColor
        //        cell.modifyPlayer(player: &selectedPlayer)
        
        cell.playerNameBackgroundColor.backgroundColor = selectedPlayer.playerColor
        cell.decrementPlayerScore = {
            self.playersList[indexPath.row].playerScore -= 1
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CDHelper.shared.deleteAllPlayers()
            for player in playersList {
                CDHelper.shared.saveDataToCoreData(player: player)
            }
            CDHelper.shared.deletePlayer(player: playersList[indexPath.row])
            playersList = CDHelper.shared.fetchDataFromCoreData()
            tableView.reloadData()
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will dissappear")
        CDHelper.shared.deleteAllPlayers()
        for player in playersList {
            CDHelper.shared.saveDataToCoreData(player: player)
        }
    }
    
    @IBAction func plusFifteen(_ sender: Any) {
        guard let text = scoreTextField.text else {
            return
        }
        switch scoreSegmentedOutlet.selectedSegmentIndex{
        case 0:
            playersList[selectedPlayerIndex].playerScore = playersList[selectedPlayerIndex].playerScore + 15
            self.playersTableView.reloadData()
            scoreTextField.text = ""
            self.scoreEditor.isHidden = true
        case 1:
            playersList[selectedPlayerIndex].playerScore = playersList[selectedPlayerIndex].playerScore - 15
            self.playersTableView.reloadData()
            scoreTextField.text = ""
            self.scoreEditor.isHidden = true
            
        default:
            break
        }
    }
    
    @IBAction func plusTen(_ sender: Any) {
        guard let text = scoreTextField.text else {
            return
        }
        switch scoreSegmentedOutlet.selectedSegmentIndex{
        case 0:
            playersList[selectedPlayerIndex].playerScore = playersList[selectedPlayerIndex].playerScore + 10
            self.playersTableView.reloadData()
            scoreTextField.text = ""
            self.scoreEditor.isHidden = true
        case 1:
            playersList[selectedPlayerIndex].playerScore = playersList[selectedPlayerIndex].playerScore - 10
            self.playersTableView.reloadData()
            scoreTextField.text = ""
            self.scoreEditor.isHidden = true
            
        default:
            break
        }
    }
    
    @IBAction func plusFiveBtn(_ sender: Any) {
        guard let text = scoreTextField.text else {
            return
        }
        switch scoreSegmentedOutlet.selectedSegmentIndex{
        case 0:
            playersList[selectedPlayerIndex].playerScore = playersList[selectedPlayerIndex].playerScore + 5
            self.playersTableView.reloadData()
            scoreTextField.text = ""
            self.scoreEditor.isHidden = true
        case 1:
            playersList[selectedPlayerIndex].playerScore = playersList[selectedPlayerIndex].playerScore - 5
            self.playersTableView.reloadData()
            scoreTextField.text = ""
            self.scoreEditor.isHidden = true
            
        default:
            break
        }
    }
    
    @IBAction func scoreEditorSave(_ sender: Any) {
        print("this is printed")
        guard let text = scoreTextField.text else {
            return
        }
        switch scoreSegmentedOutlet.selectedSegmentIndex{
        case 0:
            print("Segment 1 selected")
            playersList[selectedPlayerIndex].playerScore = playersList[selectedPlayerIndex].playerScore + abs(Int(text)!)
            self.playersTableView.reloadData()
            scoreTextField.text = ""
            self.scoreEditor.isHidden = true
        case 1:
            playersList[selectedPlayerIndex].playerScore = playersList[selectedPlayerIndex].playerScore - abs(Int(text)!)
            self.playersTableView.reloadData()
            scoreTextField.text = ""
            self.scoreEditor.isHidden = true
            
        default:
            break
        }
        
    }
    
    @IBAction func scoreSegmented(_ sender: Any) {
        switch scoreSegmentedOutlet.selectedSegmentIndex{
        case 0:
            print("Segment 1 selected")
            
            plusFiveOutlet.titleLabel?.text = "+5"
            plusTenOutlet.titleLabel?.text = "+10"
            plusFifteenOutlet.titleLabel?.text = "+15"
        case 1:
            
            print("Segment 2 selected")
            plusFiveOutlet.titleLabel?.text = "-5"
            plusTenOutlet.titleLabel?.text = "-10"
            plusFifteenOutlet.titleLabel?.text = "-15"
            
        default:
            break
        }
    }
    
    @IBAction func scoreEditorCancel(_ sender: Any) {
        scoreTextField.text = ""
        self.scoreEditor.isHidden = true
    }
    
    @IBAction func addingPlayer(_ sender: Any) {
        CDHelper.shared.deleteAllPlayers()
        for player in self.playersList {
            CDHelper.shared.saveDataToCoreData(player: player)
        }
        let player = PlayerModel(playerName:self.newPlayerTextField.text,playerScore: 0 , playerColor: Utils.colorArray.randomElement() ?? UIColor.magenta)
        CDHelper.shared.saveDataToCoreData(player: player)
        self.playersList = CDHelper.shared.fetchDataFromCoreData()
        self.playersTableView.reloadData()
        self.newPlayerTextField.text = ""
        self.customPlayerAdding.isHidden = true
    }
    
    @IBAction func cancelAddingPlayer(_ sender: Any) {
        self.newPlayerTextField.text = ""
        self.customPlayerAdding.isHidden = true
    }
}
