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

struct Player: Decodable {
    let steamid: String
    let name: String
    let kills: Int
    let assists: Int
    let deaths: Int
    let mvps: Int
    let score: Int
    let team: TeamName
    let position: Vec2
    
    init(name: String, kills: Int, assists: Int, deaths: Int, mvps: Int, score: Int, team: TeamName) {
        steamid = "K"
        self.name = name
        self.kills = kills
        self.assists = assists
        self.deaths = deaths
        self.mvps = mvps
        self.score = score
        self.team = team
        position = Vec2(x: 0, y: 0)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        steamid = try values.decode(String.self, forKey: .steamid)
        name = try values.decode(String.self, forKey: .name)
        let statistics = try values.decode([String: Int].self, forKey: .statistics)
        kills = statistics["kills"]!
        assists = statistics["assists"]!
        deaths = statistics["deaths"]!
        mvps = statistics["mvps"]!
        score = statistics["score"]!
        if let key = decoder.codingPath.first {
            let components = String(describing: key).components(separatedBy: ".")
            if let last = components.last {
                team = TeamName(rawValue: last)!
            } else {
                team = .terrorists
            }
        } else {
            team = .counterTerrorists
        }
        let _position = try values.decode(String.self, forKey: .position)
        let xyz = _position.components(separatedBy: ", ")
        if let xy = [Float(xyz[0]), Float(xyz[1])] as? [Float] {
            position = Vec2(x: CGFloat(xy[0]), y: CGFloat(xy[1]))
        } else {
            position = Vec2(x: 0, y: 0)
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
}
