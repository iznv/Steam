//
//  AppDetails.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public struct AppDetails: Codable {
    
    public let name: String
    
    public let steamAppid: Int
    
    public let isFree: Bool
    
    public let shortDescription: String
    
    public let headerImage: String
    
    public let publishers: [String]
    
    public let priceOverview: PriceOverview?
    
    public let platforms: Platforms
    
    public let metacritic: Metacritic?
    
    public let genres: [Genre]?
    
    public let screenshots: [Screenshot]?
        
    public let recommendations: Recommendations?
    
    public let releaseDate: ReleaseDate
    
    public let background: String

}

private extension AppDetails {
    
    enum CodingKeys: String, CodingKey {
        
        case name
        
        case steamAppid = "steam_appid"
        
        case isFree = "is_free"
        
        case shortDescription = "short_description"
        
        case headerImage = "header_image"
        
        case publishers
        
        case priceOverview = "price_overview"
        
        case platforms
        
        case metacritic
        
        case genres
        
        case screenshots
                
        case recommendations
        
        case releaseDate = "release_date"
        
        case background
        
    }
    
}
