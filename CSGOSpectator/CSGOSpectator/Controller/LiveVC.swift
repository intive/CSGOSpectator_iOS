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
    
    var currentMatch: Game = {
        var match = Game()
        match.map = "de_dust2"
        match.team_ct.score = 6
        match.team_t.score = 9
        match.round = 16
        match.phase_ends_in = 79
        return match
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackground()
        updateResultsView()
    }

    func updateResultsView() {
        headerView.roundLabel.text = "Round \(currentMatch.round)"
        headerView.scoreLabel.text = "\(currentMatch.team_ct.score) - \(currentMatch.team_t.score)"
        headerView.remainingTimeLabel.text = "\(currentMatch.phase_ends_in.secondsToMinutesSeconds().minutes):\(currentMatch.phase_ends_in.secondsToMinutesSeconds().seconds)"
    }
    
    func updateBackground() {
        backgroundImageView.image = UIImage(named: currentMatch.map)
    }

}

/*extension LiveVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}*/

