//
//  PlayerCustomCell.swift
//  Screw Score
//
//  Created by Mostfa Sobaih on 26/04/2024.
//

import UIKit

class PlayerCustomCell: UITableViewCell {
    
    @IBOutlet weak var cardBg: UIImageView!
    @IBOutlet weak var playerNameText: UILabel!
    
    @IBOutlet weak var scoreText: UILabel!
    
    @IBOutlet weak var playerNameBackgroundColor: UILabel!
    
    @IBOutlet weak var colorWell: UIColorWell!
    @IBOutlet weak var backGroundImage: UIImageView!
    
    @IBOutlet weak var incrementButton: UIButton!
    
    @IBOutlet weak var decrementButton: UIButton!
    
    @IBOutlet weak var backGroundLabel: UILabel!
    
    var incrementPlayerScore: ( () -> (Void) )?
    
    var decrementPlayerScore: ( () -> (Void) )?
    
    var changePlayerColor: ( () -> (Void) )?
    
    var changePlayerName: ( () -> Void)?
    
    var changePlayerScore : ( () -> Void )?
    
    var pickeColor : UIColor?
    
    @IBOutlet weak var minusButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorWell.addTarget(self, action: #selector(changeBgColor), for: .valueChanged)
       
        let nameTap = UITapGestureRecognizer(target: self, action: #selector(PlayerCustomCell.nameLabelTap))
             playerNameText.isUserInteractionEnabled = true
             playerNameText.addGestureRecognizer(nameTap)
         
        let scoreTap = UITapGestureRecognizer(target: self, action: #selector(PlayerCustomCell.scoreTap))
             scoreText.isUserInteractionEnabled = true
             scoreText.addGestureRecognizer(scoreTap)
        
        backGroundLabel.layer.cornerRadius = 20 // Set your desired corner radius here
            backGroundLabel.layer.masksToBounds = true
        
        let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: playerNameBackgroundColor.bounds,
                                          byRoundingCorners: [.topLeft, .topRight],
                                          cornerRadii: CGSize(width: 20, height: 20)).cgPath
            playerNameBackgroundColor.layer.mask = maskLayer
    }
 
    
    @objc func changeBgColor(){
        self.playerNameBackgroundColor.backgroundColor = colorWell.selectedColor
        self.pickeColor = colorWell.selectedColor
        changePlayerColor?()
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
    
    
    @IBAction func nameLabelTap(sender: UITapGestureRecognizer) {
        changePlayerName?()
    }
    @IBAction func scoreTap(sender: UITapGestureRecognizer) {
        changePlayerScore?()
    }
}
//
//
//extension PlayerCustomCell : ModifyPlayerModel{
//    func modifyPlayer( player: inout PlayerModel) {
//        if let color = pickeColor {
//            player.playerColor = color
//        }
//    }
//    
//    
//}
