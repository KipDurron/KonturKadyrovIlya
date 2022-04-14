//
//  ExInt.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 13.04.2022.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self)) ?? "\(self)"
    }
    
    func toShortedFormat() -> String {
        let num = Double(self)
        var thousandNum = num/1000
        var millionNum = num/1000000
        if num >= 1000 && num < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum)) " + Constants.thousandlabel)
            }
            return("\(thousandNum.roundToPlaces(places: 1)) " + Constants.thousandlabel)
        }
        if num > 1000000{
            return ("\(millionNum.roundToPlaces(places: 1)) " + Constants.millionlabel)
        }
        else{
            if(floor(num) == num){
                return ("\(Int(num))")
            }
            return ("\(num)")
        }
    }
}

//MARK: - Constants

private extension Int {
    enum Constants {
        static let thousandlabel = "тыс"
        static let millionlabel = "млн"
    }
}
