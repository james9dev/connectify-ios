//
//  SettingFeature.swift
//  Connectify
//
//  Created by James on 7/24/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct SettingFeature {
    
    @ObservableState
    struct State: Equatable {
        
        static let initialState = State()
        
        let id = UUID()
    }
    
    // Action
    enum Action {
        case popToRootButtonTapped
        case popToProfileRoot
    }
    
    // Environment
    //    struct LoginEnvironment {}
    
    // Reducer
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
            case .popToRootButtonTapped:
                return .run { send in
                    await send(.popToProfileRoot)
                }
            case .popToProfileRoot:
                break
            }
            
            return .none            
        }
    }
}
