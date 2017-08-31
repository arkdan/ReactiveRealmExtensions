//
//  Results.swift
//  ReactiveRealm
//
//  Created by mac on 8/31/17.
//  Copyright © 2017 arkdan. All rights reserved.
//

import Foundation
import RealmSwift
import ReactiveSwift
import Result

extension RealmSwift.Results {
    public func signalProducer() -> SignalProducer<[T], NoError> {
        return SignalProducer { observer, lifetime in

            let token = self.addNotificationBlock { changeset in
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

    public func valueAdded() -> Signal<T, NoError> {
        let (signal, observer) = Signal<T, NoError>.pipe()

        let token = addNotificationBlock { changeset in
            switch changeset {
            case .update(_, _, let insertions, _):
                insertions.forEach { observer.send(value: self[$0]) }
            default:
                break
            }
        }

        signal.observeCompleted { token.stop() }
        signal.observeInterrupted { token.stop() }

        return signal
    }
}
