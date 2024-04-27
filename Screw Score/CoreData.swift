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
    func saveDataToCoreData(player:PlayerModel){
        //1
        guard let contextManager = contextManager else { return }
        
        let entity = NSEntityDescription.entity(forEntityName: "Player", in: contextManager)
        
        guard let myEntity = entity else { return }
        
        do{
            let players = NSManagedObject(entity: myEntity, insertInto: contextManager)
            players.setValue(player.playerName, forKey: "name")
            players.setValue(player.playerScore, forKey: "score")
            try contextManager.save()
            print("Player inserted successfully")
        }catch let err{
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
