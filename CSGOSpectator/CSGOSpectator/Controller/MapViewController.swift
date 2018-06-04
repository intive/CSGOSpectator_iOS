//
//  MapViewController.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 25.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import CSGOSpectatorKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var playersView: UIView!
    @IBOutlet weak var playerDrawerView: PlayerDrawerView!
    
    var drawerPresented = false
    
    var currentMatch: Game?
    var players = [Player]()
    var dots = [UIButton]()
    let dotSize: CGFloat = 14       //Size of the player's dot
    let mapSize: CGFloat = 4450     //Size of the in-game map
    
    var center = CGPoint()
    
    var pickedPlayerSteamId: String?
    var pickedPlayer: Player?
    var cellSize = CGSize()
    
    let cellIdentifier = "cell"
    
    var profiles = [String: SteamProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapImageView.image = #imageLiteral(resourceName: "de_dust2_map")
        print("Center: \(center)")
        addPlayerDots()
        playerDrawerView.collectionView.delegate = self
        playerDrawerView.collectionView.dataSource = self
        let nib = UINib(nibName: "WeaponCollectionViewCell", bundle: nil)
        playerDrawerView.collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        playerDrawerView.closeCallback = {
            self.showDrawer(false)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCenter()
        updateDotsPosition()
        cellSize = CGSize(width: 28, height: 28)
    }
    
}

/* Drawing players on map */
extension MapViewController {
    
    func setCenter() {
        let x = playersView.frame.width * 0.5333
        let y = playersView.frame.height * 0.688
        center = CGPoint(x: x, y: y)
    }
    
    func addPlayerDots() {
        for i in 0 ..< players.count {
            if currentMatch?.team(for: players[i]) == .terrorists {
                addPlayerDot(tag: i, color: UIColor.terroristRed)
            } else {
                addPlayerDot(tag: i, color: UIColor.counterBlue)
            }
        }
    }
    
    func addPlayerDot(tag: Int, color: UIColor?) {
        let frame = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
        let playerDot = UIButton(type: .system)
        playerDot.frame = frame
        playerDot.layer.cornerRadius = frame.width / 2
        playerDot.backgroundColor = color
        playerDot.clipsToBounds = true
        playerDot.tag = tag
        playerDot.addTarget(self, action: #selector(playerPressed(_:)), for: .touchUpInside)
        dots.append(playerDot)
        playersView.addSubview(playerDot)
    }
    
    func locationForPlayer(_ player: Player) -> CGPoint {
        let ratio = mapSize / mapImageView.bounds.height
        var position = CGPoint(x: player.position.x / ratio, y: -player.position.y / ratio)
        position.x += center.x
        position.y += center.y
        return position
    }
    
    func updateDotsPosition() {
        guard !dots.isEmpty else { return }
        for (index, dot) in dots.enumerated() {
            dot.center = locationForPlayer(players[index])
        }
    }
    
    @objc func playerPressed(_ sender: UIButton) {
        guard let index = dots.index(of: sender) else { return }
        print("You pressed on \(players[index].name)")
        let player = players[index]
        for weapon in player.weapons {
            print(weapon.name.rawValue)
        }
        pickedPlayerSteamId = player.steamid
        updateDrawerInfo()
        showDrawer(true)
    }
    
    func updateDrawerInfo() {
        if let player = pickedPlayer {
            playerDrawerView.nameLabel.text = player.name
            let team = currentMatch?.team(for: player)
            let color = team == .counterTerrorists ? UIColor.counterBlue : UIColor.terroristRed
            playerDrawerView.nameLabel.textColor = color
            playerDrawerView.imageView.layer.borderColor = color.cgColor
            let health = player.state.health
            let newHealthFrame = CGRect(x: playerDrawerView.currentHealth.frame.origin.x, y: playerDrawerView.currentHealth.frame.origin.y, width: (playerDrawerView.healthBar.frame.width-2) * (CGFloat(health) / 100), height: playerDrawerView.healthBar.frame.height-2)
            playerDrawerView.currentHealth.frame = newHealthFrame
            
            let armor = player.state.armor
            let newArmorFrame = CGRect(x: playerDrawerView.currentArmor.frame.origin.x, y: playerDrawerView.currentArmor.frame.origin.y, width: (playerDrawerView.armorBar.frame.width-2) * (CGFloat(armor) / 100), height: playerDrawerView.armorBar.frame.height-2)
            playerDrawerView.currentArmor.frame = newArmorFrame
            playerDrawerView.collectionView.reloadData()
            
            if let avatarUrl = profiles[player.steamid]?.avatarUrl {
                playerDrawerView.imageView.af_setImage(withURL: avatarUrl)
            } else {
                playerDrawerView.imageView.image = #imageLiteral(resourceName: "blank_profile")
            }
        }
    }
    
    func showDrawer(_ show: Bool) {
        if show {
            if !drawerPresented {
                let moveUp = CGAffineTransform(translationX: 0, y: -96)
                UIView.animate(withDuration: 0.5, animations: {
                    self.playerDrawerView.transform = moveUp
                }, completion: { _ in
                    self.drawerPresented = true
                })
            }
        } else {
            let moveDown = CGAffineTransform(translationX: 0, y: 96)
            UIView.animate(withDuration: 0.5, animations: {
                self.playerDrawerView.transform = moveDown
            }, completion: { _ in
                self.drawerPresented = false
            })
        }
    }
    
}

extension MapViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pickedPlayer?.weapons.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? WeaponCollectionViewCell, let weapons = pickedPlayer?.weapons else { return UICollectionViewCell() }
        let weapon = weapons[indexPath.row]
        cell.setup(weapon: weapon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
}
