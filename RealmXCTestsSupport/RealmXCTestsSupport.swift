//
//  RealmXCTestsSupport.swift
//  RealmXCTestsSupport
//
//  Created by mac on 11/17/17.
//  Copyright © 2017 arkdan. All rights reserved.
//

import Foundation
import XCTest

import RealmSwift
import RealmSupport

open class TestCase: XCTestCase {
    static private var realmIsSet = false
    open override func setUp() {
        super.setUp()
        if !TestCase.realmIsSet {
            RealmSupport.makeRealm = testRealm
            TestCase.realmIsSet = true
        }
    }
}

private var databaseVersion: UInt64 {
    return 1
}

public extension Realm.Configuration {
    public static var testConfiguration: Realm.Configuration = {
        var configuration = Realm.Configuration.defaultConfiguration
        var url = configuration.fileURL!
        let lastPathComponent = "test" + url.lastPathComponent
        url = url.deletingLastPathComponent().appendingPathComponent(lastPathComponent)
        configuration.fileURL = url
        return configuration
    }()
}

extension Realm {

    final class func migrate(to version: UInt64 = databaseVersion) {
        Configuration.testConfiguration.schemaVersion = version
    }
}

func testRealm() -> Realm {
    return try! Realm(configuration: .testConfiguration)
}
