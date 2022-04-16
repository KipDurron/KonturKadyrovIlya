//
//  ParameterRealmService.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 15.04.2022.
//

import Foundation
import RealmSwift

class ParameterRealmService {
    
    let realmSetting = RealmSetting()
    let realm: Realm
    
    init() {
        realm = realmSetting.getRealm()
    }
    
    func update(parameter: ParameterRealmModel) -> String? {
        guard let pdateParameter = self.getById(name: parameter.name) else {
            return nil
        }
        do {
            realm.beginWrite()
            pdateParameter.name = parameter.name
            pdateParameter.leftTitleSegmentText = parameter.leftTitleSegmentText
            pdateParameter.rightTitleSegmentText = parameter.rightTitleSegmentText
            pdateParameter.selectedSegmentIndex = parameter.selectedSegmentIndex
            try realm.commitWrite()
        } catch {
            debugPrint(error)
        }
        return pdateParameter.name
    }
    
    func updateSelectedSegmentIndex(name: String, selectedSegmentIndex: Int) -> String? {
        guard let pdateParameter = self.getById(name: name) else {
            return nil
        }
        do {
            realm.beginWrite()
            pdateParameter.selectedSegmentIndex = selectedSegmentIndex
            try realm.commitWrite()
        } catch {
            debugPrint(error)
        }
        return pdateParameter.name
    }
    
    func saveAll(parameters: [ParameterRealmModel]) {
        for parameter in parameters {
            _ = save(parameter: parameter)
        }
    }
    
    func save(parameter: ParameterRealmModel) -> String? {
        do {
            if !self.checkExist(name: parameter.name) {
                realm.beginWrite()
                realm.add(parameter)
                try realm.commitWrite()
                return parameter.name
            }
        } catch {
            debugPrint(error)
        }
        return nil
    }
    
    func checkExist(name: String) -> Bool{
        return getById(name: name) != nil
    }
    
    func getById(name: String) -> ParameterRealmModel? {
        return realm.objects(ParameterRealmModel.self).filter("name == %@", name).first
    }
    
    func loadAll() -> [ParameterRealmModel] {
        return realm.objects(ParameterRealmModel.self).map{$0}
    }
    
    func createStartParameters() {
        let heightParameterModel = ParameterRealmModel(name: ParameterNameEnum.height.rawValue,
                                                       labelName: Constants.heightParameterLabel,
                                                       leftTitleSegmentText: MFtEnum.m.rawValue,
                                                       rightTitleSegmentText: MFtEnum.ft.rawValue)
        let diameterParameterModel = ParameterRealmModel(name: ParameterNameEnum.diameter.rawValue,
                                                         labelName: Constants.diameterParameterLabel,
                                                         leftTitleSegmentText: MFtEnum.m.rawValue,
                                                         rightTitleSegmentText: MFtEnum.ft.rawValue)
        let massParameterModel = ParameterRealmModel(name: ParameterNameEnum.mass.rawValue,
                                                     labelName: Constants.massParameterLabel,
                                                     leftTitleSegmentText: KgLbEnum.kg.rawValue,
                                                     rightTitleSegmentText: KgLbEnum.lb.rawValue)
        let payloadParameterModel = ParameterRealmModel(name: ParameterNameEnum.payload.rawValue,
                                                        labelName: Constants.payloadParameterLabel,
                                                        leftTitleSegmentText: KgLbEnum.kg.rawValue,
                                                        rightTitleSegmentText: KgLbEnum.lb.rawValue)
        saveAll(parameters: [heightParameterModel, diameterParameterModel, massParameterModel, payloadParameterModel])
    }
    
}

//MARK: - Constants

private extension ParameterRealmService {
    enum Constants {
        static let heightParameterLabel = "Высота"
        static let diameterParameterLabel = "Диаметр"
        static let massParameterLabel = "Масса"
        static let payloadParameterLabel = "Полезная нагрузка"
    }
}
