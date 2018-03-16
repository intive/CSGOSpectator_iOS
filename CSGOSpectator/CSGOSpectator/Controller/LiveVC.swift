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
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var currentMatch = Game()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false      //Disable scrolling if content fits on the screen
        headerView.backgroundColor = .clear
        randomMatch()
        let timer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(randomMatch), userInfo: nil, repeats: true)
        timer.fire()
    }

    func updateResultsView() {
        headerView.roundLabel.text = "Round \(currentMatch.round)"
        headerView.scoreLabel.text = "\(currentMatch.team_ct.score) - \(currentMatch.team_t.score)"
        let seconds = currentMatch.phase_ends_in.secondsToMinutesSeconds().seconds
        var secondsStr = "\(seconds)"
        if seconds < 10 {
            secondsStr = "0" + secondsStr
        }
        headerView.remainingTimeLabel.text = "\(currentMatch.phase_ends_in.secondsToMinutesSeconds().minutes):\(secondsStr)"
    }
    
    func updateBackground() {
        backgroundImageView.image = UIImage(named: currentMatch.map)
    }
    
    func populateTeams() {
        var ct = [Player]()
        var t = [Player]()
        let _names = "Pasha Goat Fluffy Amsterdam SerekWiejski Guru BOT_Yani BOT_Fred Nani Lollipop"
        let names = _names.components(separatedBy: " ")
        for i in 0 ..< 5 {
            var tmp = Player()
            tmp.name = names[i]
            tmp.assists = Int(arc4random_uniform(UInt32(5)+1))
            tmp.kills = Int(arc4random_uniform(UInt32(14)))
            tmp.mvps = Int(arc4random_uniform(UInt32(4)))
            tmp.deaths = Int(arc4random_uniform(UInt32(10)))
            tmp.score = Int(arc4random_uniform(UInt32(50)))
            tmp.team = "ct"
            ct.append(tmp)
        }
        for i in 5 ..< 10 {
            var tmp = Player()
            tmp.name = names[i]
            tmp.assists = Int(arc4random_uniform(UInt32(5)+1))
            tmp.kills = Int(arc4random_uniform(UInt32(14)))
            tmp.mvps = Int(arc4random_uniform(UInt32(4)))
            tmp.deaths = Int(arc4random_uniform(UInt32(10)))
            tmp.score = Int(arc4random_uniform(UInt32(50)))
            tmp.team = "t"
            t.append(tmp)
        }
        currentMatch.team_t.players.append(contentsOf: t)
        currentMatch.team_ct.players.append(contentsOf: ct)
        currentMatch.players.append(contentsOf: ct)
        currentMatch.players.append(contentsOf: t)
        currentMatch.players.sort(by: { $0.score > $1.score })
    }
    
    @objc func randomMatch(){
        let maps = ["de_dust2", "de_inferno", "de_train", "de_mirage"]
        currentMatch = {
            var match = Game()
            match.map = maps[Int(arc4random_uniform(UInt32(maps.count)))]
            match.team_ct.score = Int(arc4random_uniform(UInt32(15)))
            match.team_t.score = Int(arc4random_uniform(UInt32(15)))
            match.round = match.team_ct.score + match.team_t.score + 1
            match.phase_ends_in = Int(arc4random_uniform(UInt32(90)))
            return match
        }()
        updateBackground()
        updateResultsView()
        currentMatch.team_t.players.removeAll()
        currentMatch.team_ct.players.removeAll()
        currentMatch.players.removeAll()
        currentMatch.players.removeAll()
        populateTeams()
        tableView.reloadData()
    }

}

extension LiveVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 18
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMatch.team_ct.players.count + currentMatch.team_t.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
        cell.setup(player: currentMatch.players[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "header")
        return header?.contentView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}



