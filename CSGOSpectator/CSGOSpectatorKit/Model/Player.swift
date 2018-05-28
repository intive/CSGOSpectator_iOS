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
    public let statistics: Statistics
    public let weapons: [Weapon]
    public let state: State
    
    //var isAlive: Bool { return state.health > 0 }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        steamid = try values.decode(String.self, forKey: .steamid)
        name = try values.decode(String.self, forKey: .name)
        statistics = try values.decode(Player.Statistics.self, forKey: .statistics)
        let pos = try values.decode(String.self, forKey: .position)
        let xyz = pos.components(separatedBy: ", ")
        if let xy = [Double(xyz[0]), Double(xyz[1])] as? [Double] {
            position = CGPoint(x: xy[0], y: xy[1])
        } else {
            position = CGPoint(x: 0, y: 0)
        }
        weapons = try values.decode([Weapon].self, forKey: .weapons)
        state = try values.decode(Player.State.self, forKey: .state)
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
