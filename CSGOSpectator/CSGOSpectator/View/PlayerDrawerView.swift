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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "weaponCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "weaponCell")
    }

}

extension PlayerDrawerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return player?.weapons.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weaponCell", for: indexPath) as? WeaponCollectionViewCell else { return UICollectionViewCell() }
        guard let weapon = player?.weapons[indexPath.row] else { return UICollectionViewCell() }
        cell.setup(weapon: weapon)
        return cell
    }
    
}
