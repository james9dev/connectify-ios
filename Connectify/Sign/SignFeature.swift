//
//  SignFeature.swift
//  Connectify
//
//  Created by James on 7/20/24.
//

import ComposableArchitecture
import Foundation
import KakaoSDKAuth
import KakaoSDKUser

@Reducer
struct SignFeature {
    
    // State
    @ObservableState
    struct State: Equatable {
        let id = UUID()
        var username: String = "ID"
        var password: String = "pw"
		
		var signFailAlert: Bool = false
		var signFailMessage: String = ""
		
        var isLoggedIn: Bool = false
    }

    // Action
    enum Action: BindableAction {
        case kakaoButtonTapped
		case signoutButtonTapped
        case signnedIn(AuthTokenDto)
		case signnedFail(String)
		
        case binding(BindingAction<State>)
    }
	

    // Environment
//    struct LoginEnvironment {}

	@Dependency(\.signClient) var client // <- here
	
    // Reducer
    var body: some ReducerOf<Self> {
    
        BindingReducer()
        
        Reduce { state, action in
            switch action {
				
			case .kakaoButtonTapped:
								
				return .run { send in
					
					let kakaoResult = try await client.loginWithKakaoTalk()
					
					if let error = kakaoResult.error {
						await send(.signnedFail(error.localizedDescription))
						return
					}
							
					if let kakaoToken = kakaoResult.accessToken {
						let result = try await client.signWithKakao(kakaoToken)
						
						if result.success(), let authToken = result.data, !authToken.accessToken.isEmpty {							
							await send(.signnedIn(authToken))
						} else {
							await send(.signnedFail(result.message))
						}
					}
				}
				
			case .signoutButtonTapped:
				state.isLoggedIn = false				
				return .none
            case .signnedIn(_):
                return .none
			case .signnedFail(let message):
				
				state.signFailMessage = message
				state.signFailAlert = true
				
				return .none
            case .binding(\.username):
                print("username", state.username)
                return .none
                
           case .binding(\.password):
                print("Password", state.password)
                return .none
                
           case .binding(_):                
                return .none
            }
        }
    }
}
