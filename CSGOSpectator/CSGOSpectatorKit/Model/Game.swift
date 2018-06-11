//
//  Match.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

public struct Game: Decodable {
    public let map: String
    public let round: Int
    public let phase: String
    public let phaseEndsIn: Int
    public let teamCT: Team
    public let teamT: Team
    
    public var players: [Player] { return teamCT.players + teamT.players }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        map = try values.decode(String.self, forKey: .map)
        round = try values.decode(Int.self, forKey: .round)
        phase = try values.decode(String.self, forKey: .phase)
        let counter = try values.decode(String.self, forKey: .phaseEndsIn)
        phaseEndsIn = Float(counter).map { Int($0) } ?? 0
        teamCT = try values.decode(Team.self, forKey: .teamCT)
        teamT = try values.decode(Team.self, forKey: .teamT)
    }
    
    public enum CodingKeys: String, CodingKey {
        case map
        case round
        case phase
        case phaseEndsIn = "phase_ends_in"
        case players
        case teamCT = "team_ct"
        case teamT = "team_t"
    }
    
    public func team(for player: Player) -> TeamName {
        return teamT.players.contains(player) ? .terrorists : .counterTerrorists
    }
}
