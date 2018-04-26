//
//  PlayerDetailsCollectionViewCell.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 24.04.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

class PlayerDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var healthView: UIView!
    var player: Player!
    
    func setup(team: TeamName) {
        nameLabel.text = player.name
        if team == .counterTerrorists {
            nameLabel.textColor = UIColor.counterBlue
        } else {
            nameLabel.textColor = UIColor.terroristRed
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
//        let health: CGFloat = 70 * 0.1
//        let healthBar = UIView(frame: CGRect(x: 0, y: 0, width: healthView.frame.width * health, height: healthView.frame.height))
//        healthBar.backgroundColor = .red
//        healthView.addSubview(healthBar)
        layer.cornerRadius = 16
    }

}
