//
//  Player.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit

enum TeamName: String, Decodable {
    case terrorists = "teamT"
    case counterTerrorists = "teamCT"
    
    enum CodingKeys: String, CodingKey {
        case terrorists = "team_t"
        case counterTerrorists = "team_ct"
    }
}

struct Player: Decodable, Equatable {
    
    let steamid: String
    let name: String
    let position: CGPoint
    let statistics: Statistics
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        steamid = try values.decode(String.self, forKey: .steamid)
        name = try values.decode(String.self, forKey: .name)
        let stats = try values.decode(Player.Statistics.self, forKey: .statistics)
        self.statistics = Statistics(kills: stats.kills, assists: stats.assists, deaths: stats.deaths, mvps: stats.mvps, score: stats.score)
        let pos = try values.decode(String.self, forKey: .position)
        let xyz = pos.components(separatedBy: ", ")
        if let xy = [Double(xyz[0]), Double(xyz[1])] as? [Double] {
            position = CGPoint(x: xy[0], y: xy[1])
        } else {
            position = CGPoint(x: 0, y: 0)
        }
    }
    
    enum CodingKeys: String, CodingKey {
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
    }
    
    public struct Statistics: Decodable {
        let kills: Int
        let assists: Int
        let deaths: Int
        let mvps: Int
        let score: Int
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.steamid == rhs.steamid
    }
}
