//
//  NewsService.swift
//  Steam
//
//  Created by Ivan Zinovyev on 02/12/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

import ApiKit
import SteamKit
import WEBBCode

// MARK: - Constants

private enum Constants {
    
    static let bbcode = 1
    
    static let html = 0
    
    static let steamClanImageBaseUrlPlaceholder = "{STEAM_CLAN_IMAGE}"
    
    static let steamClanImageBaseUrl = "https://steamcdn-a.akamaihd.net/steamcommunity/public/images/clans"
    
}

class NewsService {
    
    // MARK: - Services
    
    private let steamNewsService = SteamNewsService()
    
    private let bbCodeHtmlConverter: WEBBCodeHtmlConverter = {
        let converter = WEBBCodeHtmlConverter()
        converter.transformer = SteamBBCodeHtmlTagTransformer()
        return converter
    }()
    
}

// MARK: - Public

extension NewsService {
    
    func recentNews(appId: Int,
                    completion: @escaping (Result<[Article], ApiService.Error>) -> Void) {
        
        steamNewsService.getNewsForApp(appId: appId) { [weak self] result in
            guard let self = self else { return }
            completion(result.map { $0.articles(bbcHtmlConverter: self.bbCodeHtmlConverter) })
        }
    }
    
}

// MARK: - Private

private extension Array where Element == NewsItem {
    
    func articles(bbcHtmlConverter: WEBBCodeHtmlConverter) -> [Article] {
        return compactMap { newsItem -> Article? in
            switch newsItem.feedType {
            case Constants.html:
                return Article(title: newsItem.title,
                               date: newsItem.date,
                               htmlContents: newsItem.contents)
            case Constants.bbcode:
                let contents = newsItem.contents
                    .replacingOccurrences(of: Constants.steamClanImageBaseUrlPlaceholder,
                                          with: Constants.steamClanImageBaseUrl)
                let htmlContents = (try? bbcHtmlConverter.html(fromBBCode: contents)) ?? .empty
                return Article(title: newsItem.title,
                               date: newsItem.date,
                               htmlContents: htmlContents)
            default:
                return nil
            }
        }
    }
    
}
