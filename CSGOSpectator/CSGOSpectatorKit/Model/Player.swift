//
//  Player.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

public enum TeamName: String, Decodable {
    case terrorists = "teamT"
    case counterTerrorists = "teamCT"
    
    enum CodingKeys: String, CodingKey {
        case terrorists = "team_t"
        case counterTerrorists = "team_ct"
    }
}

public struct Player: Decodable {

    public let steamid: String
    public let name: String
    public let position: CGPoint
    public let forward: CGVector
    public let statistics: Statistics
    public let weapons: [Weapon]
    public let state: State

    public var isAlive: Bool { return state.health > 0 }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        steamid = try values.decode(String.self, forKey: .steamid)
        name = try values.decode(String.self, forKey: .name)
        statistics = try values.decode(Player.Statistics.self, forKey: .statistics)
        let position = try values.decode(String.self, forKey: .position).components(separatedBy: ", ").compactMap { Double($0) }
        self.position = CGPoint(x: position[0], y: position[1])
        weapons = try values.decode([Weapon].self, forKey: .weapons)
        state = try values.decode(Player.State.self, forKey: .state)
        let forward = try values.decode(String.self, forKey: .forward).components(separatedBy: ", ").compactMap { Double($0) }
        self.forward = CGVector(dx: forward[0], dy: forward[1])
    }
    
    public enum CodingKeys: String, CodingKey {
        case steamid
        case name
        case kills
        case assists
        case deaths
        case mvps
        case score
        case team
        case statistics
        case position
        case forward
        case weapons
        case state
    }
    
    public struct Statistics: Decodable {
        public let kills: Int
        public let assists: Int
        public let deaths: Int
        public let mvps: Int
        public let score: Int
    }
    
}

/* Parameters struct and enum for determining Player's state */
extension Player {
    
    public struct State: Decodable {
        public let health: Int
        public let armor: Int
    }
    
}

/* Equatable protocol */
extension Player: Equatable {
    
    public static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.steamid == rhs.steamid
    }
}

/* Description */
//extension Player: CustomStringConvertible {
//
//    var description: String {
//        return "SteamID: \(steamid)\nName: \(name)\nAlive: \(isAlive)\nHealth: \(state.health), Armor: \(state.armor)\nPosX: \(position.x), PosY: \(position.y)\nStatistics: \(statistics)\nWeapons: \n\(weapons)"
//    }
//
//}
