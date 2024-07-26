//
//  SignScreen+ex.swift
//  Connectify
//
//  Created by James on 7/22/24.
//

import Foundation

extension SignScreen.State: Identifiable {
    var id: UUID {
        
        switch self {
        case let .signView(state):
            state.id
        case let .kakaoView(state):
            state.id
        }
        
    }
}
