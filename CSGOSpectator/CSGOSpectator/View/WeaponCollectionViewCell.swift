//
//  WeaponCollectionViewCell.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 10.05.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

class WeaponCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func setup(weapon: Weapon) {
        imageView.image = UIImage(named: weapon.name.rawValue) ?? nil
        if weapon.state == .active {
            imageView.tintColor = .red
        } else {
            imageView.tintColor = .black
        }
    }

}
