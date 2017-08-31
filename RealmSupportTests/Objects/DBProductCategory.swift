//
//  DBProductCategory.swift
//  RealmSupportTests
//
//  Created by mac on 11/17/17.
//  Copyright © 2017 arkdan. All rights reserved.
//

import Foundation
import RealmSwift
@testable import RealmSupport

final class DBProductCategory: ModelObject {
    @objc dynamic var name: String = ""
    let products = List<DBProduct>()
}

class Dog: Object {
    @objc dynamic var name: String = ""
    let owners = LinkingObjects(fromType: Person.self, property: "dogs")

    open override class func primaryKey() -> String? {
        return "name"
    }
}

class Person: Object {
    @objc dynamic var name: String = ""
    let dogs = List<Dog>()

    open override class func primaryKey() -> String? {
        return "name"
    }
}
