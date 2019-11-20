//
//  Game.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct Game: Codable {
    
    let appId: Int
    
    let name: String
    
    let playtime2Weeks: Int
    
    let playtimeForever: Int
    
    let imgIconURL: String
    
    let imgLogoURL: String
    
    let playtimeWindowsForever: Int
    
    let playtimeMacForever: Int
    
    let playtimeLinuxForever: Int
    
}

private extension Game {
    
    enum CodingKeys: String, CodingKey {
        
        case appId = "appid"
        
        case name
        
        case playtime2Weeks = "playtime_2weeks"
        
        case playtimeForever = "playtime_forever"
        
        case imgIconURL = "img_icon_url"
        
        case imgLogoURL = "img_logo_url"
        
        case playtimeWindowsForever = "playtime_windows_forever"
        
        case playtimeMacForever = "playtime_mac_forever"
        
        case playtimeLinuxForever = "playtime_linux_forever"
        
    }
    
}
