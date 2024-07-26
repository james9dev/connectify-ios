//
//  CancelBag.swift
//  Tin Can
//
//  Created by James on 2023/06/26.
//  Copyright © 2023 SRC. All rights reserved.
//

import Combine

open class CancelBag {
    public var subscriptions = Set<AnyCancellable>()
    
    public func cancel() {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
}

extension AnyCancellable {
    public func store(in cancelBag: CancelBag) {
        cancelBag.subscriptions.insert(self)
    }
}

