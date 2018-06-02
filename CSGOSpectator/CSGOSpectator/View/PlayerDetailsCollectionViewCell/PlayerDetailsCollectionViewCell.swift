//
//  PlayerDetailsCollectionViewCell.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 24.04.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import CSGOSpectatorKit

class PlayerDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var clanLabel: UILabel!
    @IBOutlet weak var nickLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var steamButton: UIButton!
    
    var borderColor: CGColor!
    
    var buttonCallback: (() -> Void)?
    
    func setup(with profile: SteamProfile, image: UIImage?, team: TeamName) {
        nickLabel.text = profile.name
        countryLabel.text = profile.countryCode?.flagEmoji ?? "-"
        nameLabel.text = profile.realName ?? "-"
        clanLabel.text = "-"
        avatarImageView.image = image
        if team == .counterTerrorists {
            avatarImageView.backgroundColor = UIColor.counterBlue
        } else {
            avatarImageView.backgroundColor = UIColor.terroristRed
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        mainView.layer.cornerRadius = 16
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor.gray.cgColor
        avatarImageView.layer.cornerRadius = 2
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = borderColor
    }
    
    @IBAction func steamButtonPressed(_ sender: UIButton) {
        buttonCallback?()
    }

}
