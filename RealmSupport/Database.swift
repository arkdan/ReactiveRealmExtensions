//
//  Database.swift
//  RealmSupport
//
//  Created by mac on 8/21/17.
//  Copyright © 2017 Arkadi Daniyelian. All rights reserved.
//

import Foundation
import RealmSwift


public extension Realm {

    public static func migrate(version: UInt64 = 1) {
        Configuration.defaultConfiguration.schemaVersion = version
    }
}

public var makeRealm: () -> Realm = {
    return try! Realm()
}
