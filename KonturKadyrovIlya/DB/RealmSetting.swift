//
//  RealmSetting.swift
//  KonturKadyrovIlya
//
//  Created by Илья Кадыров on 15.04.2022.
//

import Foundation

import Foundation
import RealmSwift

class RealmSetting {
    let realm: Realm
    init() {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            self.realm = try Realm(configuration: config)
        } catch {
            debugPrint(error)
            fatalError("Error with Realm")
        }
    }
    
    func getRealm() -> Realm {
        return realm
    }
}
