//
//  CoreData.swift
//  Screw Score
//
//  Created by husayn on 27/04/2024.
//

import Foundation
import CoreData
import UIKit

class CDHelper {
    private let contextManager: NSManagedObjectContext

    static let shared = CDHelper()

    private init() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Unable to access AppDelegate")
        }
        contextManager = appDelegate.persistentContainer.viewContext
    }

    func saveDataToCoreData(player: PlayerModel) {
        let entity = NSEntityDescription.entity(forEntityName: "Player", in: contextManager)
        guard let myEntity = entity else {
            print("Entity description not found")
            return
        }

        let newPlayer = NSManagedObject(entity: myEntity, insertInto: contextManager)
        newPlayer.setValue(player.playerName, forKey: "name")
        newPlayer.setValue(player.playerScore, forKey: "score")
        let colorData = try? NSKeyedArchiver.archivedData(withRootObject: player.playerColor, requiringSecureCoding: false)
        newPlayer.setValue(colorData, forKey: "color")

        do {
            try contextManager.save()
            print("Player inserted successfully")
        } catch {
            print("Error saving player: \(error)")
        }
    }

    func fetchDataFromCoreData() -> [PlayerModel] {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        do {
            let players = try contextManager.fetch(fetchRequest)
            print("Fetched \(players.count) players")
            return players.compactMap { player in
                guard let playerName = player.name,
                      let playerScore = player.score as? Int32,
                      let colorData = player.color,
                      let playerColor = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor else {
                    return PlayerModel()
                }
                return PlayerModel(playerName: playerName, playerScore: Int(playerScore), playerColor: playerColor)
            }
        } catch {
            print("Error fetching players: \(error)")
            return []
        }
    }

    func deleteAllPlayers() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Player.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try contextManager.execute(deleteRequest)
            try contextManager.save()
            print("All players deleted successfully")
        } catch {
            print("Error deleting players: \(error)")
        }
    }
    func deletePlayer(player: PlayerModel) {
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name = %@", player.playerName ?? "")

        do {
            let result = try contextManager.fetch(fetchRequest)
            guard let playerToDelete = result.first else {
                print("Player not found")
                return
            }
            contextManager.delete(playerToDelete)
            try contextManager.save()
            print("Player deleted successfully")
        } catch {
            print("Error deleting player: \(error)")
        }
    }

}
