//
//  PlayerCustomCell.swift
//  Screw Score
//
//  Created by Mostfa Sobaih on 26/04/2024.
//

import UIKit

class PlayerCustomCell: UITableViewCell {
    
    @IBOutlet weak var playerNameText: UILabel!
    
    @IBOutlet weak var scoreText: UILabel!
    
    @IBOutlet weak var backGroundImage: UIImageView!
    
    @IBOutlet weak var incrementButton: UIButton!
    
    @IBOutlet weak var decrementButton: UIButton!
    var incrementPlayerScore: ( () -> (Void) )?
    
    var decrementPlayerScore: ( () -> (Void) )?
    
    @IBOutlet weak var minusButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
