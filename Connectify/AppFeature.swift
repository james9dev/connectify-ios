//
//  AppFeature.swift
//  Connectify
//
//  Created by James on 7/23/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct AppFeature {
        
    @ObservableState
    struct State: Equatable {
        
        static let initialState = State(signS: .initialState, mainS: .initialState)
        
        var signS: SignCoordinator.State
        var mainS: MainCoordinator.State
        
        var isSignnedIn: Bool = false

    }
    
    enum Action {
        case signA(SignCoordinator.Action)
        case mainA(MainCoordinator.Action)
        
        case signout
    }    
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.signS, action: \.signA) {
            SignCoordinator()
        }
        
        Scope(state: \.mainS, action: \.mainA) {
            MainCoordinator()
        }

        Reduce<State, Action> { state, action in
            
            switch action {
            case .signA(.router(.routeAction(_, .signView(.signinButtonTapped)))):
                break
            case .signA(.router(.routeAction(_, .signView(.signnedIn(let signned))))):
                
                state.isSignnedIn = signned
                
                break
            case .mainA(.signout):
                
                state.isSignnedIn = false
                
                break
            case .signout:
                
                state.mainS = .initialState
                state.isSignnedIn = false
                
                break
            default:
                break
            
            }
            
            return .none
            
        }
    }
    
}
