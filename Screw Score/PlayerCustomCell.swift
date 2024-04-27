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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editPlayerButton(_ sender: Any) {
        
        
    }
    
    
    @IBAction func incrementScore(_ sender: Any) {
        guard var score = Int(scoreText.text ?? "0") else { return }
        score += 1
        scoreText.text = String(score)

    }
    
    
    @IBAction func decrementScore(_ sender: Any) {
        guard var score = Int(scoreText.text ?? "0") else { return }
        score -= 1
        scoreText.text = String(score)
    }
    
    
}
