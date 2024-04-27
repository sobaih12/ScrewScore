//
//  ViewController.swift
//  Screw Score
//
//  Created by Mostfa Sobaih on 26/04/2024.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var playersTableView: UITableView!
    var playersList : [PlayerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var player1 = PlayerModel(playerName: "Mostafa" , playerScore: 0)
        var player2 = PlayerModel(playerName: "Michael" , playerScore: 0)
        var player3 = PlayerModel(playerName: "Husayn" , playerScore: 0)
        var player4 = PlayerModel(playerName: "Marey" , playerScore: 0)
        playersList = [player1,player2,player3,player4]
    }

    @IBAction func addingNewPlayer(_ sender: Any) {
        var alert = UIAlertController(title: "Add Player", message: "Enter Player Name : ", preferredStyle: .alert)
        
        
         alert.addTextField()
         var ffield = alert.textFields?.first
        
        var yesAction = UIAlertAction(title: "yes", style: .default){
           _ in
            print(ffield?.text ?? "Ali")
            let player = PlayerModel(playerName:ffield?.text,playerScore: 0)
            self.playersList.append(player)
            self.playersTableView.reloadData()
        }
        var action = UIAlertAction(title: "no", style: .destructive)
       
        
        alert.addAction(yesAction)
        alert.addAction(action)
        
        present(alert, animated: true)

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(playersList.count)
        return playersList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as! PlayerCustomCell
        var selectedPlayer = playersList[indexPath.row]
        cell.playerNameText.text = selectedPlayer.playerName
        cell.scoreText.text = "\(selectedPlayer.playerScore!)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
               if let indexPath = tableView.indexPath(for: cell) {
                   let oldScore = playersList[indexPath.row].playerScore
                   let newScore = oldScore! + 1
                   // Use indexPath here
                   updatePlayerScore(at: indexPath, with: newScore)
               }
           }
    }
    @IBAction func incrementScore(_ sender: UIButton) {
        
    }
    
    
    
    func updatePlayerScore(at indexPath:IndexPath,with newValue:Int){
        playersList[indexPath.row].playerScore = newValue
        playersTableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    
}

