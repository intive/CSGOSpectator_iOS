//
//  SteamClient.swift
//  CSGOSpectator
//
//  Created by Adam Wienconek on 27.05.2018.
//  Copyright © 2018 intive. All rights reserved.
//

import UIKit
import Alamofire
import CSGOSpectatorKit

class SteamClient {
    
    enum OperationResult {
        case success
        case fail
    }
    
    enum Paths: String {
        case base = "https://csgospectator.herokuapp.com"
        case email = "/api/steam/config/"   // add email adress after ' / '
        case players = "/api/steam/players?steamids="   // add players' id's eg. [76561198176564946,76561198013533038]
        
        var fullPath: String {
            switch self {
            case .email:
                return Paths.base.rawValue + Paths.email.rawValue
            default:
                return Paths.base.rawValue
            }
        }
    }
    
    func requestEmail(address: String, completion: @escaping ((OperationResult) -> Void)) {
        
        let path = Paths.email.fullPath + address
        guard let url = URL(string: path) else {
            print("Could not create email URL")
            completion(.fail)
            return
        }
        
        Alamofire.request(url)
            .response { response in
                guard response.error == nil else {
                    print("Error while requesting Email: \(address)\n\(response.error!.localizedDescription)")
                    completion(.fail)
                    return
                }
                completion(.success)
        }
        
    }
    
}
