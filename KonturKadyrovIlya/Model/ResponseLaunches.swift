//
//  ResponseLaunches.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import Foundation

struct ResponseLaunches: Decodable {
    let launches: [LaunchModel]
    
    enum CodingKeys: String, CodingKey {
        case launches = "docs"
    }
}
