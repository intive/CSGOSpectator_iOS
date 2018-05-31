//
//  PlayerDetailsViewController.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 24.04.2018.
//  Copyright © 2018 intive. All rights reserved.
//

//
//  PlayerVC.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 27.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import CSGOSpectatorKit

protocol PlayerDetailsViewControllerDelegate: class {
    func viewDismissed()
}

class PlayerDetailsViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var currentMatch: Game?
    var players = [Player]()
    var pickedPlayerIndex = 0
    var initialTouchPoint = CGPoint()
    
    var cellSize: CGSize?
    
    weak var dismissDelegate: PlayerDetailsViewControllerDelegate?
    let client = SteamClient()
    var profiles = [SteamProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let cellNib = UINib(nibName: "PlayerDetailsCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "cell")
        
        let steamIds = players.map { (player) -> String in
            return player.steamid
        }
        client.requestSteamProfiles(steamIDs: steamIds) { (profiles, result) in
            switch result {
            case .success:
                self.profiles = profiles ?? []
                self.collectionView.reloadData()
            case .fail:
                print("Couldn't get Steam profiles")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if cellSize == nil {
            let width = collectionView.frame.width
            guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            layout.itemSize = CGSize(width: width, height: width * 1.1)
            //collectionView.reloadData()
            guard !players.isEmpty else { return }
            let path = IndexPath(row: pickedPlayerIndex, section: 0)
            collectionView.scrollToItem(at: path, at: .left, animated: false)
        }
    }
    
    func presentSteamProfile(player: Player) {
        print("Will show steam profile for \(player.name)")
    }
    
}

extension PlayerDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PlayerDetailsCollectionViewCell else { return UICollectionViewCell() }
        let player = players[indexPath.row]
        let team = currentMatch?.team(for: player) ?? TeamName.counterTerrorists
        cell.setup(player: player, team: team)
        if !profiles.isEmpty {
            let profile = profiles[indexPath.row]
            cell.countryLabel.text = profile.name
        }
        cell.buttonCallback = { [weak self] in
            self?.presentSteamProfile(player: player)
        }
        return cell
    }
    
}

/* Handling gestures */
extension PlayerDetailsViewController: UIGestureRecognizerDelegate {
    
    @IBAction func panGestureHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: view)
        switch sender.state {
        case .began:
            initialTouchPoint = touchPoint
        case .changed:
            if touchPoint.y - initialTouchPoint.y > 0 {
                view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: view.frame.width, height: view.frame.height)
            }
        case .ended:
            if touchPoint.y - initialTouchPoint.y > 100 {
                //dismiss
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height)
                }, completion: { _ in
                    self.dismiss(animated: false)
                })
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                })
                //back
            }
        default:
            print("Default")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: view.window) else { return }
        if !collectionView.frame.contains(location) {
            self.dismiss(animated: true)
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissDelegate?.viewDismissed()
        super.dismiss(animated: flag, completion: completion)
    }
    
}
