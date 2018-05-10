//
//  PlayerDrawerView.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 10.05.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

class PlayerDrawerViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var healthBar: UIView!
    @IBOutlet weak var armorBar: UIView!
    
    var player: Player?
    var team: TeamName?
    var weapons = [Weapon]()
    
    @IBOutlet weak var currentHealth: UIView!
    @IBOutlet weak var currentArmor: UIView!
    var cellSize = CGSize()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = collectionView.frame.height
        cellSize = CGSize(width: width, height: width)
    }
    
    func updateInfo() {
        imageView.image = #imageLiteral(resourceName: "pasha")
        nameLabel.text = player?.name ?? "No name"
        if team == .counterTerrorists {
            nameLabel.textColor = .blue
        } else {
            nameLabel.textColor = .red
        }
        guard let health = player?.state.health else { return }
        let newHealthFrame = CGRect(x: currentHealth.frame.origin.x, y: currentHealth.frame.origin.y, width: (healthBar.frame.width-2) * (CGFloat(health) / 100), height: healthBar.frame.height-2)
        currentHealth.frame = newHealthFrame
        
        guard let armor = player?.state.armor else { return }
        let newArmorFrame = CGRect(x: currentArmor.frame.origin.x, y: currentArmor.frame.origin.y, width: (armorBar.frame.width-2) * (CGFloat(armor) / 100), height: armorBar.frame.height-2)
        currentArmor.frame = newArmorFrame
        
        if let wep = player?.weapons { weapons = wep }
        collectionView.reloadData()
    }

}

extension PlayerDrawerViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weapons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WeaponCollectionViewCell else { return UICollectionViewCell() }
        let weapon = weapons[indexPath.row]
        cell.setup(weapon: weapon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
}
