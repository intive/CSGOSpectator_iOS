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
    
    var pageController: PageViewController?
    var currentMatch: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let jsonData = getJSON(named: "model") else { return }
        currentMatch = gameFromJSON(json: jsonData)
        updateChildViews()
        updateBackground()
        updateResultsView()
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
            guard let page = pageController else { return }
            page.currentMatch = curr
            
            guard let stats = page.pages[0] as? StatsViewController else { return }
            stats.currentMatch = curr
            stats.players = curr.players.sorted(by: { $0.statistics.score > $1.statistics.score })
            stats.tableView.reloadData()
            
            guard let map = page.pages[1] as? MapViewController else { return }
            map.currentMatch = curr
            map.players = curr.players
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PageViewController {
            self.pageController = destination
        }
    }

}

/* JSON handling */
extension LiveViewController {
    
    func getJSON(named: String) -> Data? {
        if let path = Bundle.main.path(forResource: named, ofType: "json") {
            let url = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                return data
            } catch let err {
                print("Couldn't open json file named '\(named)'\n\(err.localizedDescription)")
                return nil
            }
        } else {
            print("Couldn't open json file named '\(named)'")
            return nil
        }
    }
    func gameFromJSON(json: Data) -> Game? {
        do {
            let game = try JSONDecoder().decode(Game.self, from: json)
            return game
        } catch let err {
            print(err.localizedDescription)
            return nil
        }
    }
}
