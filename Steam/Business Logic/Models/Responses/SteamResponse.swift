//
//  SteamResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

class SteamResponse<T: Codable>: Codable {

    let response: T?

}
