//
//  Product.swift
//  RealmSupportTests
//
//  Created by mac on 11/17/17.
//  Copyright © 2017 arkdan. All rights reserved.
//

import Foundation
import RealmSwift
@testable import RealmSupport

struct Product {
    var number: Int

    var id: String {
        return "\(number)"
    }
}

extension Product: Equatable {
    static func ==(lhs: Product, rhs: Product) -> Bool {
        return lhs.number == rhs.number
    }
}

extension Product: RealmConvertible {
    init(object: DBProduct) {
        number = object.number
    }
    func toObject() -> DBProduct {
        let object = DBProduct()
        object.number = number
        object.id = id
        return object
    }
}
