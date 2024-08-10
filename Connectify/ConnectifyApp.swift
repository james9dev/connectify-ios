//
//  ConnectifyApp.swift
//  Connectify
//
//  Created by James on 7/18/24.
//

import SwiftUI
import ComposableArchitecture
import KakaoSDKCommon

@main
struct ConnectifyApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    static let store = Store(initialState:  AppFeature.State.initialState) {
        AppFeature()._printChanges()
    }
    
    init() {
		
//		let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KakaoAppKey") as? String ?? ""
		let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KakaoAppKeyTest") as? String ?? ""
		
		KakaoSDK.initSDK(appKey: kakaoAppKey)
		
		ConnectifyApp.store.send(.autoSignin)
		
    }
    
    var body: some Scene {
        WindowGroup {
            //CounterView(store: ConnectifyApp.store)
            //SignView(store: ConnectifyApp.store)
            
            AppView(store: ConnectifyApp.store)                
            
//            MainCoordinatorView(store: Store(initialState: MainCoordinator.State.initialState, reducer: {
//                
//                MainCoordinator()
//            }))
            
            
//            SignCoordinatorView(store: Store(initialState: .initialState, reducer: {
//                SignCoordinator()
//            }))
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                
                break
            case .inactive:
                
                break
            case .active:
                
                break
            @unknown default:
                break
            }
        }
        
    }
}
