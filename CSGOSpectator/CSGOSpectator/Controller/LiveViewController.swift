//
//  LieveViewController.swift
//  CSGOSpectator
//
//  Created by Mateusz Fidos on 03.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import CSGOSpectatorKit

class LiveViewController: UIViewController {
    
    @IBOutlet weak var headerView: ResultsHeaderView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var blurBackground: UIVisualEffectView!
    
    var pageController: PageViewController?
    var currentMatch: Game?
    
    var gameStates = [Game]()
    var gameIndex = 0
    
    var steamIds = [String]()
    let client = SteamClient(steamId: "76561198070124545")
    var players = [Player]()
    var profiles = [String: SteamProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        client.delegate = self
        blurBackground.alpha = 0
    }

    func updateResultsView() {
        headerView.updateWithGameData(currentMatch)
    }
    
    func updateBackground() {
        if let match = currentMatch {
            backgroundImageView.image = UIImage(named: match.map)
        } else {
            backgroundImageView.image = nil
        }
    }
    
    func updateChildViews() {
        
        if let curr = currentMatch {
            
            players = curr.players.sorted(by: { $0.statistics.score > $1.statistics.score })
            steamIds = players.map { (player) -> String in
                return player.steamid
            }
            
            guard let page = pageController else { return }
            page.currentMatch = curr
            
            guard let stats = page.pages[0] as? StatsViewController else { return }
            stats.parentLiveViewController = self
            stats.currentMatch = curr
            stats.players = self.players
            stats.profiles = self.profiles
            stats.detailsViewController?.collectionView.reloadData()
            stats.tableView.reloadData()
            
            guard let map = page.pages[1] as? MapViewController else { return }
            map.currentMatch = curr
            map.players = curr.players
            map.profiles = self.profiles
            map.updateDotsPosition()
            let filtered = curr.players.filter({ $0.steamid == map.pickedPlayerSteamId })
            if let picked = filtered.first {
                map.pickedPlayer = picked
            }
            map.updateDrawerInfo()
        }
    }
    
    func getSteamProfiles() {
        if steamIds.isEmpty {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (_) in
                self.getSteamProfiles()
            })
        } else {
            client.requestSteamProfiles(steamIDs: steamIds) { (received, result) in
                switch result {
                case .success:
                    if let profs = received {
                        for profile in profs {
                            self.profiles.updateValue(profile, forKey: profile.id)
                        }
                    }
                case .fail:
                    print("Couldn't get Steam profiles")
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PageViewController {
            self.pageController = destination
        }
    }
    
    func changeStatusBarAppearance(style: UIStatusBarStyle) {
        UIApplication.shared.statusBarStyle = style
    }

}

extension LiveViewController: SteamClientDelegate {
    
    func didReceiveGameData(_ game: Game) {
        currentMatch = game
        self.updateChildViews()
        self.updateResultsView()
        self.updateBackground()
        self.getSteamProfiles()
    }
}
