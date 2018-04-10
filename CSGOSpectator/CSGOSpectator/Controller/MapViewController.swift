//
//  MapViewController.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 25.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapImageView: UIImageView!
    @IBOutlet weak var playersView: UIView!
    
    var currentMatch: Game?
    var players = [Player]()
    var dots = [UIButton]()
    let dotSize: CGFloat = 10       //Size of the player's dot
    let mapSize: CGFloat = 4450     //Size of the in-game map
    
    var center = CGPoint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapImageView.image = #imageLiteral(resourceName: "de_dust2_map")
        print("Center: \(center)")
        addPlayerDots()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCenter()
        updateDotsPosition()
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
        for index in 0 ..< players.count {
            let location = locationForPlayer(players[index])
            let dot = dots[index]
            let frame = CGRect(x: location.x, y: location.y, width: dotSize, height: dotSize)
            dot.frame = frame
        }
    }
    
    @objc func playerPressed(_ sender: UIButton) {
        print("You pressed on \(players[sender.tag].name)")
    }
    
}
