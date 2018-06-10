//
//  PlayerDrawerView.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 12.05.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import CSGOSpectatorKit

class PlayerDrawerView: UIView, ReusableViewProtocol {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var healthBar: UIView!
    @IBOutlet weak var armorBar: UIView!
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var currentHealthViewWidthConstaint: NSLayoutConstraint!
    @IBOutlet weak var currentArmorViewWidthConstaint: NSLayoutConstraint!
    
    var closeCallback: (() -> Void)?
    
    override required init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        Bundle.main.loadNibNamed("PlayerDrawerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    @IBAction func closePressed() {
        closeCallback?()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        mainView.layer.cornerRadius = 6
        mainView.layer.borderWidth = 2
        mainView.layer.borderColor = UIColor.gray.cgColor
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 28, height: 28)
        }
    }

    func configure(player: Player, team: TeamName, avatarUrl: URL?) {
        nameLabel.text = player.name
        let color = team == .counterTerrorists ? UIColor.counterBlue : UIColor.terroristRed
        nameLabel.textColor = color
        imageView.layer.borderColor = color.cgColor
        let health = player.state.health
        currentHealthViewWidthConstaint.constant = (healthBar.frame.width - 2) * (CGFloat(health) / 100)
        let armor = player.state.armor
        currentArmorViewWidthConstaint.constant = (armorBar.frame.width - 2) * (CGFloat(armor) / 100)
        UIView.animate(withDuration: 1) {
            self.healthBar.layoutIfNeeded()
            self.armorBar.layoutIfNeeded()
        }
        if let avatarUrl = avatarUrl {
            imageView.af_setImage(withURL: avatarUrl)
        } else {
            imageView.image = #imageLiteral(resourceName: "blank_profile")
        }
        collectionView.reloadData()
    }

}
