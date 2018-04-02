//
//  Team.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

struct Team: Decodable {
    let score: Int
    let players: [Player]
    let name: String
    
    init(score: Int, players: [Player]) {
        self.score = score
        self.players = players
        name = ""
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Team.CodingKeys.self)
        score = try values.decode(Int.self, forKey: .score)
        players = try values.decode([Player].self, forKey: .players)
        if let key = decoder.codingPath.first {
            name = String(describing: key)
        } else {
            name = "Empty"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case score
        case players
    }
}
