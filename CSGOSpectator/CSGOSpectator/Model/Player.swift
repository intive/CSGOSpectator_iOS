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
    let position: CGPoint
    let statistics: Statistics
    let weapons: [Weapon]
    
    init(from decoder: Decoder) throws {
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
        let weaponsDictionary = try values.decode([String: [String: String]].self, forKey: .weapons)
        var newWeapons = [Weapon]()
        for index in 0 ... 10 {
            if let weaponInfo = weaponsDictionary["weapon_\(index)"] {
                if let type = Weapon.WeaponType(rawValue: weaponInfo["type"]!) {
                    if let name = Weapon.WeaponName(rawValue: weaponInfo["name"]!) {
                        if let state = Weapon.WeaponState(rawValue: weaponInfo["state"]!) {
                            let newWeapon = Weapon(name: name, type: type, state: state)
                            newWeapons.append(newWeapon)
                        }
                    }
                }
            } else {
                /* If no more weapons, stop searching */
                break
            }
        }
        weapons = newWeapons
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
        case weapons
    }
    
    public struct Statistics: Decodable {
        let kills: Int
        let assists: Int
        let deaths: Int
        let mvps: Int
        let score: Int
    }
    
}

/* Equatable protocol */
extension Player: Equatable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.steamid == rhs.steamid
    }
}

/* Description */
extension Player: CustomStringConvertible {
    
    var description: String {
        return "SteamID: \(steamid)\nName: \(name)\nPosX: \(position.x), PosY: \(position.y)\nWeapons: \n\(weapons)"
    }
    
}
