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
        
    }
    @IBAction func settings(_ sender: Any) {
        for player in playersList{
            print("this player name is \(player.playerName) and his score is \(player.playerScore)")
        }
    }
    
    @IBAction func addingNewPlayer(_ sender: Any) {
        let alert = UIAlertController(title: "Add Player", message: "Enter Player Name : ", preferredStyle: .alert)
        
        
         alert.addTextField()
         let ffield = alert.textFields?.first
        
        let yesAction = UIAlertAction(title: "yes", style: .default){
           _ in
            print(ffield?.text ?? "Ali")
            let player = PlayerModel(playerName:ffield?.text,playerScore: 0)
            self.playersList.append(player)
            self.playersTableView.reloadData()
        }
        let action = UIAlertAction(title: "no", style: .destructive)
       
        
        alert.addAction(yesAction)
        alert.addAction(action)
        
        present(alert, animated: true)

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
        cell.decrementPlayerScore = {
            self.playersList[indexPath.row].playerScore -= 1
            tableView.reloadRows(at: [indexPath], with: .fade)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        // Calculate the height based on the cell count or any other criteria
//            let totalCellCount = tableView.numberOfRows(inSection: indexPath.section)
//        let defaultHeight: CGFloat = 200.0 // Set your default cell height here
//
//            // Example: Increase cell height if there are fewer cells
//            let maxCellCount: CGFloat = 10 // Maximum cell count where cell height will be minimum
//            let minHeight: CGFloat = 100.0
//            let maxHeight: CGFloat = 200.0
//
//            let dynamicHeight = minHeight + (maxHeight - minHeight) * (1 - CGFloat(totalCellCount) / maxCellCount)
//
//            return dynamicHeight
        return 200
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            playersList.remove(at: indexPath.row)
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

}

