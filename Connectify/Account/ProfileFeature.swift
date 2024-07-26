//
//  ProfileFeature.swift
//  Connectify
//
//  Created by James on 7/24/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct ProfileFeature {
        
    let service = GlobalEventService()
    
    @ObservableState
    struct State: Equatable {
        
        static let initialState = State()
        
        let id = UUID()
    }

    enum Action {
        case signoutButtonTapped
        case settingButtonTapped
    }

    // Environment
//    struct LoginEnvironment {}

    // Reducer
    var body: some ReducerOf<Self> {
            
        Reduce { state, action in
            switch action {

            case .signoutButtonTapped:
                return .run { _ in
                    GlobalEventService.service.signOut()
                }
            case .settingButtonTapped:
                
                break
            }
            
            return .none
            
        }
    }
    
}
