//
//  ParameterRealmModel.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 15.04.2022.
//

import RealmSwift

class ParameterRealmModel: Object {
    
    //MARK: - Properties
    
    @objc dynamic var name: String
    @objc dynamic var labelName: String
    @objc dynamic var leftTitleSegmentText: String
    @objc dynamic var rightTitleSegmentText: String
    @objc dynamic var selectedSegmentIndex: Int
    
    //MARK: - life cycle
    
    init(name: String = "", labelName : String = "", leftTitleSegmentText: String = "", rightTitleSegmentText: String = "", selectedSegmentIndex: Int = 0) {
        self.name = name
        self.labelName = labelName
        self.leftTitleSegmentText = leftTitleSegmentText
        self.rightTitleSegmentText = rightTitleSegmentText
        self.selectedSegmentIndex = selectedSegmentIndex
    }
    
    override init() {
        self.name = ""
        self.labelName = ""
        self.leftTitleSegmentText = ""
        self.rightTitleSegmentText = ""
        self.selectedSegmentIndex = 0
    }
    
    func buildViewModel(action: ActionChangeSegmentType = nil) -> ParameterSettingViewModel {
        ParameterSettingViewModel(model: self, action: action)
    }
    
    func getTypeParameter() -> String {
        return selectedSegmentIndex == 0 ? leftTitleSegmentText : rightTitleSegmentText
    }
}

