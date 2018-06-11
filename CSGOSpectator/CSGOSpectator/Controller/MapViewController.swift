//
//  MapViewController.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 25.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import CSGOSpectatorKit
import AlamofireImage

final class MapViewController: UIViewController {
    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var playersView: UIView!
    @IBOutlet weak var playerDrawerView: PlayerDrawerView!
    
    private var drawerPresented = false
    
    var gameState: Game! {
        didSet {
            guard playersView != nil else { return }
            players = gameState.players
        }
    }
    private var players = [Player]() {
        didSet {
            if oldValue != players {
                addPlayerDots()
                if players.count < oldValue.count {
                    pickedPlayerIndex = nil
                }
            }
            updatePlayerDots()
            if drawerPresented {
                updateDrawerInfo()
            }
        }
    }
    private var pickedPlayerIndex: Int? {
        didSet {
            showDrawer(pickedPlayerIndex != nil)
            if drawerPresented {
                updateDrawerInfo()
            }
        }
    }

    private var dots = [PlayerDotView]()
    private let dotSize: CGFloat = 16       //Size of the player's dot
    private let mapSize: CGFloat = 4450     //Size of the in-game map
    
    private var center = CGPoint()
    
    private var cellSize = CGSize(width: 20, height: 20)

    private let cellIdentifier = "cell"
    
    var profiles = [String: SteamProfile]() {
        didSet {
            if drawerPresented {
                updateDrawerInfo()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapImageView.image = #imageLiteral(resourceName: "de_dust2_map")
        playerDrawerView.collectionView.delegate = self
        playerDrawerView.collectionView.dataSource = self
        let nib = UINib(nibName: "WeaponCollectionViewCell", bundle: nil)
        playerDrawerView.collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        playerDrawerView.closeCallback = { [weak self] in self?.pickedPlayerIndex = nil }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCenter()
        updatePlayerDots()
    }
    
}

/* Drawing players on map */
extension MapViewController {
    
    private func setCenter() {
        let x = playersView.frame.width * 0.5333
        let y = playersView.frame.height * 0.688
        center = CGPoint(x: x, y: y)
    }
    
    private func addPlayerDots() {
        dots.forEach { $0.removeFromSuperview() }
        dots.removeAll()
        for (index, player) in players.enumerated() {
            addPlayerDot(color: gameState.team(for: player) == .terrorists ? .terroristRed : .counterBlue) { [weak self] in self?.pickedPlayerIndex = index }
        }
    }
    
    private func addPlayerDot(color: UIColor, action: @escaping () -> Void) {
        let frame = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
        let playerDot = PlayerDotView(frame: frame)
        playerDot.clipsToBounds = true
        playerDot.button.tintColor = color
        playerDot.action = action
        dots.append(playerDot)
        playersView.addSubview(playerDot)
    }
    
    private func translate(position: CGPoint) -> CGPoint {
        let ratio = mapSize / mapImageView.bounds.height
        return CGPoint(x: position.x / ratio + center.x,
                       y: -position.y / ratio + center.y)
    }
    
    private func updatePlayerDots() {
        guard !dots.isEmpty else { return }
        for (index, player) in players.enumerated() {
            let dot = dots[index]
            UIView.animate(withDuration: 0.1) {
                dot.layer.borderWidth = self.pickedPlayerIndex == index ? 2 : 0
                dot.isHidden = !player.isAlive
                dot.center = self.translate(position: player.position)
                dot.transform = CGAffineTransform(rotationAngle: player.rotation)
            }
        }
    }

    private func updateDrawerInfo() {
        guard let index = pickedPlayerIndex else { return }
        let player = players[index]
        let team = gameState.team(for: player)
        let avatarUrl = profiles[player.steamid]?.avatarUrl
        playerDrawerView.configure(player: player, team: team, avatarUrl: avatarUrl)
    }
    
    private func showDrawer(_ show: Bool) {
        if show {
            if !drawerPresented {
                let moveUp = CGAffineTransform(translationX: 0, y: -96)
                UIView.animate(withDuration: 0.5, animations: {
                    self.playerDrawerView.transform = moveUp
                }, completion: { _ in
                    self.drawerPresented = true
                    self.updateDrawerInfo()
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
        return pickedPlayerIndex.map { players[$0].weapons.count } ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? WeaponCollectionViewCell,
                let index = pickedPlayerIndex else { return UICollectionViewCell() }
        let weapon = players[index].weapons[indexPath.row]
        cell.setup(weapon: weapon)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }

}
