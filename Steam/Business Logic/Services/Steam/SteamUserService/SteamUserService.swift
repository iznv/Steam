//
//  SteamUserService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import Foundation

private enum Constants {
    
    static let maxIdsToRequestSummaries = 100
    
}

class SteamUserService {
    
    func getPlayerSummaries(steamId: String,
                            completion: @escaping (Result<[Player], ApiService.Error>) -> Void) {
        
        ApiService.shared.getPlayerSummaries(steamIds: steamId) {
            completion($0.map { $0.response.players })
        }
    }
    
    func getPlayerSummaries(steamIds: [String],
                            completion: @escaping (Result<[Player], ApiService.Error>) -> Void) {
        
        let chunks = steamIds.chunked(into: Constants.maxIdsToRequestSummaries)
        var players = [Player]()
        
        let dispatchGroup = DispatchGroup()
        
        chunks.forEach { friendsChunk in
            dispatchGroup.enter()
            
            let ids = friendsChunk.joined(separator: String.comma)
            
            ApiService.shared.getPlayerSummaries(steamIds: ids) { result in
                if case let .success(summaries) = result {
                    players.append(contentsOf: summaries.response.players)
                }

                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.global(qos: .userInitiated)) {
            completion(.success(players))
        }
    }
    
    func getFriendList(steamId: String,
                       completion: @escaping (Result<[Friend], ApiService.Error>) -> Void) {
        
        ApiService.shared.getFriendList(steamId: steamId) {
            completion($0.map { $0.friendsList?.friends ?? [] })
        }
    }
    
    func getUserGroupList(steamId: String,
                          completion: @escaping (Result<[Group], ApiService.Error>) -> Void) {
        
        ApiService.shared.getUserGroupList(steamId: steamId) {
            if case let .success(data) = $0 {
                if data.response.success {
                    completion($0.map { $0.response.groups ?? [] })
                } else {
                    completion($0.map { _ in [] })
                }
            } else {
                completion($0.map { _ in [] })
            }
        }
    }
    
}
