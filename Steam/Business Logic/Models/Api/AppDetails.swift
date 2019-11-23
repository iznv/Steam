//
//  AppDetails.swift
//  Steam
//
//  Created by Ivan Zinovyev on 23/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

struct AppDetails: Codable {
    
    let name: String
    
    let steamAppid: Int
    
    let requiredAge: Int
    
    let isFree: Bool
    
    let shortDescription: String
    
    let headerImage: String
    
    let publishers: [String]
    
    let priceOverview: PriceOverview?
    
    let platforms: Platforms
    
    let metacritic: Metacritic
    
    let genres: [Genre]
    
    let screenshots: [Screenshot]
        
    let recommendations: Recommendations
    
    let releaseDate: ReleaseDate
    
    let background: String

}

private extension AppDetails {
    
    enum CodingKeys: String, CodingKey {
        
        case name
        
        case steamAppid = "steam_appid"
        
        case requiredAge = "required_age"
        
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
