//
//  Match.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

struct Game: Decodable {
    let map: String
    let round: Int
    let phase: String
    let phaseEndsIn: Int
    let teamCT: Team
    let teamT: Team
    
    func getPlayers() -> [Player] {
        var players = teamCT.players + teamT.players
        players.sort(by: { $0.score > $1.score })
        return players
    }
    
    init(map: String, round: Int, phase: String, phaseEndsIn: Int, players: [Player], teamCT: Team, teamT: Team) {
        self.map = map
        self.round = round
        self.phase = phase
        self.phaseEndsIn = phaseEndsIn
        self.teamCT = teamCT
        self.teamT = teamT
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        map = try values.decode(String.self, forKey: .map)
        round = try values.decode(Int.self, forKey: .round)
        phase = try values.decode(String.self, forKey: .phase)
        phaseEndsIn = (try Int(Float(values.decode(String.self, forKey: .phaseEndsIn))!))
        teamCT = try values.decode(Team.self, forKey: .teamCT)
        teamT = try values.decode(Team.self, forKey: .teamT)
    }
    
    enum CodingKeys: String, CodingKey {
        case map
        case round
        case phase
        case phaseEndsIn = "phase_ends_in"
        case players
        case teamCT = "team_ct"
        case teamT = "team_t"
    }
}
