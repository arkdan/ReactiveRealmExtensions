//
//  ProductCategory.swift
//  RealmSupportTests
//
//  Created by mac on 11/17/17.
//  Copyright © 2017 arkdan. All rights reserved.
//

import Foundation
import RealmSwift
@testable import RealmSupport

struct ProductCategory {
    var name: String
    var products = [Product]()

    var id: String {
        return name
    }
}

extension ProductCategory: Equatable {
    static func ==(lhs: ProductCategory, rhs: ProductCategory) -> Bool {
        return lhs.name == rhs.name
    }
}

extension ProductCategory: RealmConvertible {
    init(object: DBProductCategory) {
        name = object.name
    }
    func toObject() -> DBProductCategory {
        let object = DBProductCategory()
        object.name = name
        object.id = id
        products.forEach { object.products.append($0.managedObject()) }
        return object
    }

    func unpersistRelationships() {
        products.forEach { $0.unpersist() }
    }
}
