//
//  ExDouble.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 14.04.2022.
//

import Foundation

extension Double {
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}
