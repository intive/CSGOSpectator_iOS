//
//  Match.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

struct Game {
    let map: String
    let round: Int
    let phase: String
    let phaseEndsIn: Int
    
    let players: [Player]
    let teamCT: Team
    let teamT: Team
    
    init(map: String, round: Int, phase: String, phaseEndsIn: Int, players: [Player], teamCT: Team, teamT: Team) {
        self.map = map
        self.round = round
        self.phase = phase
        self.phaseEndsIn = phaseEndsIn
        self.players = players
        self.teamCT = teamCT
        self.teamT = teamT
    }
}
