//
//  RequestResult.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import Foundation

enum RequestResult<T: Decodable> {
    case error(text: String)
    case complete(data: T)
}
