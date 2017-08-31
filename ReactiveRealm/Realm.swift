//
//  Realm.swift
//  ReactiveRealm
//
//  Created by mac on 8/31/17.
//  Copyright © 2017 arkdan. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift
import Result


extension Realm {

    public func observeObjectsResult<T: RealmSwift.Object>(ofType objectType: T.Type) -> SignalProducer<Results<T>, NoError> {

        return SignalProducer { observer, lifetime in
            let collection: Results<T> = self.objects(objectType)

            let token = collection.addNotificationBlock { changeset in

                switch changeset {
                case .initial(let latestValue):
                    observer.send(value: latestValue)
                case .update(let latestValue, _, _, _):
                    observer.send(value: latestValue)
                case .error:
                    break
                }
            }

            lifetime.observeEnded {
                token.stop()
            }

        }
    }

    public func observeObjects<T: RealmSwift.Object>(ofType objectType: T.Type, offset: Int = 0, limit: Int = 0) -> SignalProducer<[T], NoError> {

        return SignalProducer { observer, lifetime in
            let collection: Results<T> = self.objects(objectType)

            let token = collection.addNotificationBlock { changeset in

                switch changeset {
                case .initial(let latestValue):
                    observer.send(value: latestValue.map { $0 })
                case .update(let latestValue, _, _, _):
                    observer.send(value: latestValue.map { $0 })
                case .error:
                    break
                }
            }

            lifetime.observeEnded {
                token.stop()
            }

        }
    }

}
