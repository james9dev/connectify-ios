//
//  SomeCombineService.swift
//  Connectify
//
//  Created by James on 7/24/24.
//

import Foundation
import Combine

struct GlobalEventService {
    
    static let service = GlobalEventService()
    
    // You can use any publisher you want, I'll be using a passthrough subject for this example
    let signedOutPublisher: PassthroughSubject<Void, Never> = .init()

    func signOut() {
        self.signedOutPublisher.send()
    }
}

