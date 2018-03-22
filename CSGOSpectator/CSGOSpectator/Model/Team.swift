//
//  Team.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

struct Team {
    let score: Int
    let players: [Player]
    
    init(score: Int, players: [Player]) {
        self.score = score
        self.players = players
    }
}
