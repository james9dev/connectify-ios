//
//  SignScreen+ex.swift
//  Connectify
//
//  Created by James on 7/22/24.
//

import Foundation

extension AccountScreen.State: Identifiable {
    var id: UUID {
        
        switch self {
        case let .profileView(state):
            state.id
        case let .settingView(state):
            state.id
        }
        
    }
}
