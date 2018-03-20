//
//  Player.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

enum TeamName: String {
    case terrorists
    case counterTerrorists
}

struct Player {
    let name: String
    let kills: Int
    let assists: Int
    let deaths: Int
    let mvps: Int
    let score: Int
    let team: TeamName
    
    init(name: String, kills: Int, assists: Int, deaths: Int, mvps: Int, score: Int, team: TeamName) {
        self.name = name
        self.kills = kills
        self.assists = assists
        self.deaths = deaths
        self.mvps = mvps
        self.score = score
        self.team = team
    }
}
