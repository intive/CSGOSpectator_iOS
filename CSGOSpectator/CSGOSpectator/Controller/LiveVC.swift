//
//  ViewController.swift
//  CSGOSpectator
//
//  Created by Mateusz Fidos on 03.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import CSGOSpectatorKit

class LiveVC: UIViewController {
    
    @IBOutlet weak var headerView: ResultsHeaderView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var container: UIView!
    
    var pageController: PageVC?
    var currentMatch: Game? {
        didSet {
            pageController?.currentMatch = currentMatch
            updateBackground()
            updateResultsView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateFakeMatch()
    }
    
    func generateFakeMatch() {
        var ct = [Player]()
        var t = [Player]()
        let names = ["Pasha", "Goat", "Fluffy", "Amsterdam", "SerekWiejski", "Guru", "BOT_Yani", "BOT_Fred", "Nani", "Lollipop"]
        for i in 0 ..< 5 {
            let tmp = Player(name: names[i], kills: Int(arc4random_uniform(UInt32(14))), assists: Int(arc4random_uniform(UInt32(5)+1)), deaths: Int(arc4random_uniform(UInt32(10))), mvps: Int(arc4random_uniform(UInt32(4))), score: Int(arc4random_uniform(UInt32(50))), team: TeamName.counterTerrorists)
            ct.append(tmp)
        }
        for i in 5 ..< 10 {
            let tmp = Player(name: names[i], kills: Int(arc4random_uniform(UInt32(14))), assists: Int(arc4random_uniform(UInt32(5)+1)), deaths: Int(arc4random_uniform(UInt32(10))), mvps: Int(arc4random_uniform(UInt32(4))), score: Int(arc4random_uniform(UInt32(50))), team: TeamName.terrorists)
            t.append(tmp)
        }
        let teamCT = Team(score: 5, players: ct)
        let teamT = Team(score: 9, players: t)
        var all = ct + t
        all.sort(by: { $0.score > $1.score })
        currentMatch = Game(map: "de_dust2", round: 15, phase: "Live", phaseEndsIn: 68, players: all, teamCT: teamCT, teamT: teamT)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PageVC {
            self.pageController = destination
        }
    }

}
