//
//  SignCoordinator.swift
//  Connectify
//
//  Created by James on 7/22/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators


struct SignCoordinatorView: View {
    let store: StoreOf<SignCoordinator>

    var body: some View {
        
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .signView(store):
                SignView(store: store)
            case let .kakaoView(store):
                KakaoView(store: store)
            }
        }
    }
}



@Reducer(state: .equatable)
enum SignScreen {
    case signView(SignFeature)
    case kakaoView(SignFeature)
}


@Reducer
struct SignCoordinator {
    
    @ObservableState
    struct State: Equatable {
                
        static let initialState = SignCoordinator.State(routes: [.root(.signView(.init()), embedInNavigationView: true)])
        
        var routes: IdentifiedArrayOf<Route<SignScreen.State>>
    }
    
    enum Action {
        case router(IdentifiedRouterActionOf<SignScreen>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            
            
            switch action {
            case .router(.routeAction(id: _, action: .signView(.kakaoButtonTapped))):
                //state.routes.push(.kakaoView(.init()))
                break
            default:
                break
            
            }
            
            return .none
            
        }.forEachRoute(\.routes, action: \.router)
    }
}
