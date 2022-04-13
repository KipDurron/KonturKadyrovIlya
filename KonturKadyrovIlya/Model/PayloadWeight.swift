//
//  PayloadWeight.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import Foundation

struct PayloadWeight: Decodable {
    let id, name: String
    let kg, lb: Int
}
