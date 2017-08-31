//
//  DBProduct.swift
//  RealmSupportTests
//
//  Created by mac on 11/17/17.
//  Copyright © 2017 arkdan. All rights reserved.
//

import Foundation
import RealmSwift
@testable import RealmSupport

final class DBProduct: ModelObject {
    @objc dynamic var number: Int = 0

    convenience init(number: Int) {
        self.init()
        self.number = number
        self.id = "\(number)"
    }
}
