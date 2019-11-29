//
//  Game.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct Game: Codable {
    
    public let appId: Int
    
    public let name: String?
    
    public let playtime2Weeks: Int?
    
    public let playtimeForever: Int
    
    public let imgIconURL: String?
    
    public let imgLogoURL: String?
    
    public let playtimeWindowsForever: Int
    
    public let playtimeMacForever: Int
    
    public let playtimeLinuxForever: Int
    
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
