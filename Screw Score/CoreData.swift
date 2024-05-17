//
//  CoreData.swift
//  Screw Score
//
//  Created by husayn on 27/04/2024.
//

import Foundation
import CoreData
import UIKit

class CDHelper{
    
    var contextManager:NSManagedObjectContext?
    var appDelegate:AppDelegate?
    var container:NSPersistentContainer?
    static var instance = CDHelper()
    
    private init(){
        appDelegate = UIApplication.shared.delegate as? AppDelegate //appdelegate
        container = appDelegate?.persistentContainer//persistent container
        contextManager = container?.viewContext//context
    }
    func saveDataToCoreData(player: PlayerModel) {
        guard let contextManager = contextManager else { return }

        let entity = NSEntityDescription.entity(forEntityName: "Player", in: contextManager)
        guard let myEntity = entity else { return }

        do {
            let newPlayer = NSManagedObject(entity: myEntity, insertInto: contextManager)
            newPlayer.setValue(player.playerName, forKey: "name")
            newPlayer.setValue(player.playerScore, forKey: "score")
            print(player.playerScore)
            let colorData = try? NSKeyedArchiver.archivedData(withRootObject: player.playerColor, requiringSecureCoding: false)
            newPlayer.setValue(colorData, forKey: "color") // Set colorData for the key "color" on newPlayer
            try contextManager.save()
            print("Player inserted successfully")
        } catch let err {
            print(err)
        }
    }
    
    func fetchDataFromCoreData() -> [PlayerModel]{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Player")
        var arrayOfPlayers:[PlayerModel] = []
        do{
            let players = try contextManager?.fetch(fetchRequest)
            print("Fetch items")
            guard let players = players else { return []}
            for player in players {
                var newPlayer = PlayerModel()
                newPlayer.playerName = player.value(forKey: "name") as? String
                newPlayer.playerScore = player.value(forKey: "score") as! Int
                print(newPlayer.playerScore,"-----")
                var retreivedColor = player.value(forKey: "color") as! Data
                if let color = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(retreivedColor) as? UIColor {
                    newPlayer.playerColor = color
                    }
                arrayOfPlayers.append(newPlayer)
            }
        }catch let err{
            print(err)
        }
        return arrayOfPlayers
    }
    
    func deleteDataFromCoreData(){
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Player")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//            let empss = try contextManager?.fetch(fetchRequest)
//            contextManager?.delete((empss?[idx])!)
            try contextManager?.execute(deleteRequest)
            try contextManager?.save()
        }catch let err{
            print("ERROR=======>\n")
            print(err.localizedDescription)
        }
    }
}
