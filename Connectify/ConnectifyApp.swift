//
//  ConnectifyApp.swift
//  Connectify
//
//  Created by James on 7/18/24.
//

import SwiftUI
import ComposableArchitecture
import KakaoSDKCommon
import GoogleMobileAds
import AppTrackingTransparency


@main
struct ConnectifyApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    static let store = Store(initialState:  AppFeature.State.initialState) {
        AppFeature()._printChanges()
    }
    
    init() {
		//GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [ "c458ae01182d2fad3701091c1e7991e0" ]
		GADMobileAds.sharedInstance().start(completionHandler: nil)

		
//		let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KakaoAppKey") as? String ?? ""
		let kakaoAppKey = Bundle.main.object(forInfoDictionaryKey: "KakaoAppKeyTest") as? String ?? ""
		
		KakaoSDK.initSDK(appKey: kakaoAppKey)
		
		ConnectifyApp.store.send(.autoSignin)
		
		UITabBar.appearance().backgroundColor = UIColor.white
		
    }
    
    var body: some Scene {
        WindowGroup {
            //CounterView(store: ConnectifyApp.store)
            //SignView(store: ConnectifyApp.store)
            
			AppView(store: ConnectifyApp.store)
				.onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
					ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in
					})
			   }
            
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
