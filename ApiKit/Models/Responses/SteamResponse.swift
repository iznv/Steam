//
//  SteamResponse.swift
//  Steam
//
//  Created by Ivan Zinovyev on 20/11/2019.
//  Copyright © 2019 Ivan Zinovev. All rights reserved.
//

public class SteamResponse<T: Codable>: Codable {

    public let response: T

}
