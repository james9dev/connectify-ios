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
        var isLoggedIn: Bool = false
    }

    // Action
    enum Action: BindableAction {
        case signinButtonTapped
        case kakaoButtonTapped
        
        case signoutButtonTapped
        
        case signnedIn(Bool)
                
        case binding(BindingAction<State>)
    }

    // Environment
//    struct LoginEnvironment {}

    // Reducer
    var body: some ReducerOf<Self> {
    
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .signinButtonTapped:
                if state.username == "ID" && state.password == "pw" {
                    state.isLoggedIn = true
                    
                }
                return .run { [isLoggedIn = state.isLoggedIn] send in
                    
                    if isLoggedIn == true {
                        
                        let (data, _) = try await URLSession.shared.data(from: URL(string: "http://numbersapi.com/\(0)")!)
                        
                        let _ = String(decoding: data, as: UTF8.self)
                        
                        await send(.signnedIn(true))
                    }
                    
                  }
            case .signnedIn:
                
                return .none
            case .kakaoButtonTapped:
                
                return .run { send in
                    
                    if UserApi.isKakaoTalkLoginAvailable() {
                        
						UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
                            if let error = error {
                                print(error)
                            } else {
								print("loginWithKakaoTalk() success: \(oauthToken)")

                                //do something
                                _ = oauthToken
                            }
                        }
						
					} else {
						
						UserApi.shared.loginWithKakaoAccount { oauthToken, error in
							if let error = error {
								print("yjk - loginWithKakaoAccount error: \(error.localizedDescription)")
								return
							}
							
							if let accessToken = oauthToken?.accessToken {
								print("yjk -  loginWithKakaoAccount() success: \(accessToken)")
								
							}
						}
					}
                    
                }
            case .signoutButtonTapped:
                state.isLoggedIn = false
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
