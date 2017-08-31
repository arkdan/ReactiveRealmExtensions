//
//  RealmConvertible.swift
//  RealmSupport
//
//  Created by ark dan on 23/07/2017.
//  Copyright © 2017 arkdan. All rights reserved.
//

import Foundation
import RealmSwift

open class ModelObject: RealmSwift.Object {
    @objc open dynamic var id: String = ""

    open override class func primaryKey() -> String? {
        return "id"
    }
}

public protocol RealmConvertible {

    associatedtype RealmObjectType: ModelObject

    var id: String { get }

    func toObject() -> RealmObjectType
    init(object: RealmObjectType)
}

public extension RealmConvertible {

    public func persist(realm: Realm = makeRealm()) {
        let object = self.toObject()
        let block = {
            _ = realm.create(RealmObjectType.self, value: object, update: true)
        }

        if realm.isInWriteTransaction {
            block()
        } else {
            try! realm.write { block() }
        }
    }

    public func unpersist(realm: Realm = makeRealm()) {

        // no need to delete if not persisted
        guard let managed = realm.object(ofType: RealmObjectType.self, forPrimaryKey: id) else {
            return
        }
        let block = {
            realm.delete(managed)
        }
        if realm.isInWriteTransaction {
            block()
        } else {
            try! realm.write { block() }
        }
        unpersistRelationships()
    }

    // should be implemented by types with relationships.
    // Workaround until Realm supports cascade delete
    public func unpersistRelationships() {
    }

    public func managedObject(realm: Realm = makeRealm()) -> RealmObjectType {

        if let managed = realm.object(ofType: RealmObjectType.self, forPrimaryKey: self.id) {
            return managed
        }

        let object = toObject()

        var managed: RealmObjectType! = nil
        let block = {
            managed = realm.create(RealmObjectType.self, value: object, update: true)
        }
        if realm.isInWriteTransaction {
            block()
        } else {
            try! realm.write { block() }
        }
        return managed
    }
}


/*
public extension RealmConvertible {

    public typealias Realationship<T: RealmSwift.Object> = (RealmObjectType) -> List<T>

    public func addValue<Model: RealmConvertible, DBModel>(_ value: Model, relationship: Realationship<DBModel>) where Model.RealmObjectType == DBModel {

        let object = value.managedObject()
        try! makeRealm().write {
            relationship(managedObject()).append(object)
        }
    }

    public func addValues<Model: RealmConvertible, DBModel>(_ values: [Model], relationship: Realationship<DBModel>) where Model.RealmObjectType == DBModel {

        let objects = values.map { $0.managedObject() }
        try! makeRealm().write {
            relationship(managedObject()).append(objectsIn: objects)
        }
    }
}
 */
