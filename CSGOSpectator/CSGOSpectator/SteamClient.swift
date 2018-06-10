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
import Starscream

protocol SteamClientDelegate: class {
    func didReceiveGameData(_ game: Game)
}

class SteamClient {
    
    let socket: WebSocket
    weak var delegate: SteamClientDelegate?
    
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
            case .players:
                return Paths.base.rawValue + Paths.players.rawValue
            default:
                return Paths.base.rawValue
            }
        }
    }
    
    init(steamId: String) {
        let url = URL(string: "ws://csgospectator.herokuapp.com/api/games/live/\(steamId)")
        socket = WebSocket(url: url!)
        socket.callbackQueue = .global(qos: .background)
        socket.delegate = self
        socket.connect()
    }
    
    func requestEmail(address: String, completion: @escaping ((OperationResult) -> Void)) {
        
        let fullPath = Paths.email.fullPath + address
        guard let url = URL(string: fullPath) else {
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
    
    func requestSteamProfiles(steamIDs: [String], completion: @escaping (([SteamProfile]?, OperationResult) -> Void)) {
        let fullPath = "\(Paths.players.fullPath)[\(steamIDs.joined(separator: ","))]"
        guard let url = URL(string: fullPath) else {
            print("Could not create email URL)")
            completion(nil, .fail)
            return
        }
        
        Alamofire.request(url, method: .get)
            
            .responseData { response in
                guard response.result.isSuccess, let data = response.result.value else {
                    print("Error while getting players\n\(String(describing: response.error?.localizedDescription))")
                    completion(nil, .fail)
                    return
                }
                do {
                    let playersArray = try JSONDecoder().decode([String: [SteamProfile]].self, from: data)
                    completion(playersArray["players"], .success)
                    return
                } catch let err {
                    print("Could not decode players JSON properly\n\(err.localizedDescription)")
                    completion(nil, .fail)
                    return
                }
        }
    }
    
}

extension SteamClient: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("WebSocket connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("WebSocket disconnected")
        socket.connect()
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        if let game = decodeData(data) {
            DispatchQueue.main.async {
                self.delegate?.didReceiveGameData(game)
            }
        }
    }
    
    private func decodeData(_ data: Data) -> Game? {
        do {
            let game = try JSONDecoder().decode(Game.self, from: data)
            return game
        } catch {
            print(error)
            return nil
        }
    }
    
}
