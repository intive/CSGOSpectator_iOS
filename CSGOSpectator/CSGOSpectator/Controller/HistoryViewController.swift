//
//  HistoryViewController.swift
//  CSGOSpectator
//
//  Created by student on 28/03/2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import CSGOSpectatorKit

class HistoryViewController: UITableViewController {
    
    struct HistoryGame {
        let map: String
        let time: String
        let ct_Score: Int
        let t_Score: Int
        let date: String
    }
    
    let games = [
        HistoryGame(map: "de_dust2", time: "24:52", ct_Score: 4, t_Score: 16, date: "08/06/2018"),
        HistoryGame(map: "de_inferno", time: "54:12", ct_Score: 16, t_Score: 13, date: "02/06/2018"),
        HistoryGame(map: "de_dust2", time: "32:58", ct_Score: 6, t_Score: 16, date: "28/05/2018"),
        HistoryGame(map: "de_mirage", time: "45:45", ct_Score: 2, t_Score: 16, date: "26/05/2018"),
        HistoryGame(map: "de_train", time: "63:23", ct_Score: 16, t_Score: 14, date: "22/05/2018"),
        HistoryGame(map: "de_inferno", time: "42:55", ct_Score: 13, t_Score: 16, date: "22/05/2018"),
        HistoryGame(map: "de_mirage", time: "56:23", ct_Score: 5, t_Score: 16, date: "20/05/2018"),
        HistoryGame(map: "de_train", time: "27:42", ct_Score: 16, t_Score: 2, date: "19/05/2018"),
        HistoryGame(map: "de_dust2", time: "62:54", ct_Score: 16, t_Score: 12, date: "18/05/2018")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HistoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 59, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? HistoryTableViewCell else { return UITableViewCell() }
        let game = games[indexPath.section]
        cell.dateLabel.text = game.date
        cell.lenghtLabel.text = game.time
        cell.mapLabel.text = game.map
        cell.mapImageView.image = UIImage(named: game.map) ?? #imageLiteral(resourceName: "blank_profile")
        
        let attributed1 = NSMutableAttributedString(string: "\(game.ct_Score)")
        let range1 = NSRange(location: 0, length: attributed1.length)
        attributed1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.counterBlue, range: range1)
        
        let plain = NSMutableAttributedString(string: " : ")
        
        let attributed2 = NSMutableAttributedString(string: "\(game.t_Score)")
        let range2 = NSRange(location: 0, length: attributed2.length)
        attributed2.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.terroristRed, range: range2)
        
        attributed1.append(plain)
        attributed1.append(attributed2)
        
        cell.scoreLabel.attributedText = attributed1
        cell.selectedBackgroundView = UIView()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 112
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
