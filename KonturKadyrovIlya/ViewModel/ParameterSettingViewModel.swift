//
//  ParameterSettingViewModel.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 15.04.2022.
//

import Foundation

typealias ActionChangeSegmentType = ((String, Int)->Void)?

struct ParameterSettingViewModel {
    var model: ParameterRealmModel
    var action: ActionChangeSegmentType = nil
}
