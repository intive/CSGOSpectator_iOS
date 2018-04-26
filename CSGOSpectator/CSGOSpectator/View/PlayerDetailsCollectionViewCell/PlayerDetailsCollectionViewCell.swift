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
    @IBOutlet weak var clanLabel: UILabel!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var steamButton: UIButton!
    
    var player: Player!
    var borderColor: CGColor!
    
    var buttonCallback: ((Player) -> Void)?
    
    func setup(team: TeamName) {
        clanLabel.text = "Empty"
        nickLabel.text = player.name
        countryLabel.text = "Empty"
        nameLabel.text = "Empty"
        if team == .counterTerrorists {
            borderColor = UIColor.counterBlue.cgColor
        } else {
            borderColor = UIColor.terroristRed.cgColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        nameLabel.text = player.name
        mainView.layer.cornerRadius = 16
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor.gray.cgColor
        avatarImageView.layer.cornerRadius = 6
        avatarImageView.layer.borderWidth = 4
        avatarImageView.layer.borderColor = borderColor
    }
    
    @IBAction func steamButtonPressed(_ sender: UIButton) {
        buttonCallback?(player)
    }

}
