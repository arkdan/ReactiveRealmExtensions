//
//  RealmSupport.swift
//  Contacts
//
//  Created by ark dan on 25/07/2017.
//  Copyright © 2017 arkdan. All rights reserved.
//

import Foundation
import RealmSwift

import ReactiveSwift
import Result

import RealmSupport


extension SignalProducer where Value: Sequence, Value.Iterator.Element: RealmSupport.ModelObject {
    public func toModelArray<Model: RealmConvertible>() -> SignalProducer<[Model], Error>
        where Model.RealmObjectType == Value.Iterator.Element {
            return map { $0.map { Model(object: $0) } }
    }
}

extension SignalProducer {
    public func toModel<Model: RealmConvertible>() -> SignalProducer<Model, Error> where Model.RealmObjectType == Value {
        return map { Model(object: $0) }
    }
}
