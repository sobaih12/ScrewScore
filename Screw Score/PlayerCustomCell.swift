//
//  PlayerCustomCell.swift
//  Screw Score
//
//  Created by Mostfa Sobaih on 26/04/2024.
//

import UIKit


protocol ModifyPlayerModel {
    func modifyPlayer(player: inout PlayerModel)
}




class PlayerCustomCell: UITableViewCell {
    
    @IBOutlet weak var cardBg: UIImageView!
    @IBOutlet weak var playerNameText: UILabel!
    
    @IBOutlet weak var scoreText: UILabel!
    
    @IBOutlet weak var colorWell: UIColorWell!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    @IBOutlet weak var incrementButton: UIButton!
    
    @IBOutlet weak var decrementButton: UIButton!
    var incrementPlayerScore: ( () -> (Void) )?
    
    var decrementPlayerScore: ( () -> (Void) )?
    
    var pickeColor : UIColor?
    
    @IBOutlet weak var minusButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        print("\(colorWell.isSelected) %%%%%% \(colorWell.selectedColor)")
        colorWell.addTarget(self, action: #selector(changeBgColor), for: .valueChanged)
        
    }
    
    @objc func changeBgColor(){
        print("\(colorWell.isSelected) %%%%%% \(colorWell.selectedColor)")
        self.cardBg.backgroundColor = colorWell.selectedColor
        self.pickeColor = colorWell.selectedColor
    }
    
    
    @IBAction func editPlayerButton(_ sender: Any) {
        print("Add")
    }
    
    @IBAction func incrementScore(_ sender: Any) {
        incrementPlayerScore?()
    }
    
    
    @IBAction func decrementScore(_ sender: Any) {
        decrementPlayerScore?()
    }
   
}


extension PlayerCustomCell : ModifyPlayerModel{
    func modifyPlayer( player: inout PlayerModel) {
        if let color = pickeColor {
            player.playerColor = color
        }
    }
    
    
}
