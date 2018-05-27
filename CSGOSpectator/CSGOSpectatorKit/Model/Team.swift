//
//  Team.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 15.03.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

public struct Team: Decodable {
    public let score: Int
    public let players: [Player]
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Team.CodingKeys.self)
        score = try values.decode(Int.self, forKey: .score)
        players = try values.decode([Player].self, forKey: .players)
    }
    
    public enum CodingKeys: String, CodingKey {
        case score
        case players
    }
}
