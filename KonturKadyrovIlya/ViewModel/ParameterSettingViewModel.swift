//
//  ParameterSettingViewModel.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 15.04.2022.
//

import Foundation

struct ParameterSettingViewModel {
    var leftLabelText: String
    var leftTitleSegmentText: String
    var rightTitleSegmentText: String
    var selectedSegmentIndex: Int = 0
    var action: (()->Void)? = nil
}
