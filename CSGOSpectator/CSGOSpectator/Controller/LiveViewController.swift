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

    var gameState: Game! {
        didSet {
            if oldValue?.map != gameState.map {
                backgroundImageView.image = UIImage(named: gameState.map) ?? #imageLiteral(resourceName: "de_dust2")
            }
            headerView.updateWithGameData(gameState)
            players = gameState.players
            pageController?.mapViewController?.gameState = gameState
            pageController?.statsViewController?.gameState = gameState
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    var client: SteamClient?
    var players = [Player]() {
        didSet {
            guard oldValue != players else { return }
            getSteamProfiles(for: players.map({ $0.steamid }))
        }
    }
    var profiles = [String: SteamProfile]() {
        didSet {
            pageController?.mapViewController?.profiles = profiles
            pageController?.statsViewController?.profiles = profiles
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blurBackground.alpha = 0
        pageController?.statsViewController?.parentLiveViewController = self
        client = SteamClient(steamId: "76561198013533038")
        client?.delegate = self
    }
    
    func getSteamProfiles(for ids: [String]) {
        client?.requestSteamProfiles(steamIDs: ids) { [weak self] (profiles, result) in
            switch result {
            case .success:
                if let profiles = profiles {
                    var dict = [String: SteamProfile]()
                    profiles.forEach { dict[$0.id] = $0 }
                    self?.profiles = dict
                }
            case .fail:
                print("Couldn't get Steam profiles")
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
        gameState = game
    }

}
