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
    
    func setup(player: Player) {
        if player.team == .terrorists {
            tLabel.text = player.name
            ctLabel.text = ""
        } else {
            ctLabel.text = player.name
            tLabel.text = ""
        }
        scoreLabel.text = "\(player.score)"
        killsLabel.text = "\(player.kills)"
        deathsLabel.text = "\(player.deaths)"
        assistsLabel.text = "\(player.assists)"
        mvpLabel.text = "\(player.mvps)"
    }
    
}
