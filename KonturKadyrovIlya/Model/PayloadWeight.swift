//
//  PayloadWeight.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import Foundation

struct PayloadWeight: Decodable {
    let id, name: String
    let mass: Mass
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case kg
        case lb
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let kg = try container.decode(Int.self, forKey: .kg)
        let lb = try container.decode(Int.self, forKey: .lb)
        mass = Mass(kg: kg, lb: lb)
    }
}
