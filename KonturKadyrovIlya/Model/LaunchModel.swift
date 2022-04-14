//
//  LaunchModel.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import Foundation

struct LaunchModel: Decodable {
    let success: Bool
    let name: String
    let dateUnix: Int
    let id: String

    enum CodingKeys: String, CodingKey {
        case success, name
        case dateUnix = "date_unix"
        case id
    }
}
