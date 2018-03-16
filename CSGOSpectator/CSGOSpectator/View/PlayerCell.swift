//
//  PlayerCell.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var ctLabel: UILabel!
    @IBOutlet weak var tLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var assistsLabel: UILabel!
    @IBOutlet weak var mvpLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(player: Player) {
        if player.team == "t" {
            tLabel.text = player.name
            ctLabel.text = ""
        }else{
            ctLabel.text = player.name
            tLabel.text = ""
        }
        scoreLabel.text = "\(player.score)"
        killsLabel.text = "\(player.kills)"
        deathsLabel.text = "\(player.deaths)"
        assistsLabel.text = "\(player.assists)"
    }
    
}
