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
		
		//let adUnitID = "ca-app-pub-1690789030518389/9124928662"
		let adUnitID = "ca-app-pub-3940256099942544/2435281174" //Test용 id
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
