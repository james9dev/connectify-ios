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
        
		case autoSignin
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
            case .signA(.router(.routeAction(_, .signView(.signnedIn(let authToken))))):
				
				KeychainHelper.create(value: authToken.accessToken, label: "auth_access_token")
				KeychainHelper.create(value: authToken.refreshToken, label: "auth_refresh_token")
				
				state.mainS.selectedTab = authToken.authType == .SignUp ? .tab4 : .tab1
				state.isSignnedIn = true
                
                break
            case .signout:
				
				KeychainHelper.delete(label: "auth_access_token")
				KeychainHelper.delete(label: "auth_refresh_token")
                
                state.mainS = .initialState
                state.isSignnedIn = false
                
                break
				
			case .autoSignin:
				
				if KeychainHelper.read(label: "auth_access_token") != nil {
					state.isSignnedIn = true
				}
				
				break
            default:
				break
            }
            
            return .none
            
        }
    }
    
}
