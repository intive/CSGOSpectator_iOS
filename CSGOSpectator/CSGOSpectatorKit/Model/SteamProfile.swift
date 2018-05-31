//
//  Profile.swift
//  CSGOSpectatorKit
//
//  Created by Adam Wienconek on 27.05.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import Foundation

public struct SteamProfile: Decodable, CustomStringConvertible {
    
    public let id: String
    public let name: String
    public let avatarUrl: URL?
    public let profileUrl: URL?
    public let realName: String?
    public let countryCode: String?
    
    public enum CodingKeys: String, CodingKey {
        case id = "steamid"
        case name = "personaname"
        case avatarUrl = "avatarfull"
        case profileUrl = "profileurl"
        case realName = "realname"
        case countryCode = "loccountrycode"
    }
    
    public var description: String {
        return "Name: \(name)\nId: \(id)\n AvatarUrl: \(avatarUrl ?? URL(string: "None")!)\nProfileUrl: \(profileUrl ?? URL(string: "None")!)"
    }
    
}
