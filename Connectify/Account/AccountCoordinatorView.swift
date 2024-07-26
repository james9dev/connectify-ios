//
//  AccountCoordinatorView.swift
//  Connectify
//
//  Created by James on 7/24/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators


struct AccountCoordinatorView: View {
    
    @State var store: StoreOf<AccountCoordinator>

    var body: some View {
        
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .profileView(store):
                ProfileView(store: store)
            case let .settingView(store):
                SettingView(store: store)
            }
        }
    }
}


@Reducer(state: .equatable)
enum AccountScreen {
    case profileView(ProfileFeature)
    case settingView(SettingFeature)
}


@Reducer
struct AccountCoordinator {
    
    @ObservableState
    struct State: Equatable {
                
        static let initialState = AccountCoordinator.State(routes: [.root(.profileView(.init()), embedInNavigationView: true)])
        
        var routes: IdentifiedArrayOf<Route<AccountScreen.State>>
    }
    
    enum Action {
        case router(IdentifiedRouterActionOf<AccountScreen>)
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce { state, action in
                        
            switch action {
            case .router(.routeAction(id: _, action: .profileView(.signoutButtonTapped))):
                
                break            
            case .router(.routeAction(id: _, action: .profileView(.settingButtonTapped))):
                state.routes.push(.settingView(.init()))
                break
            case .router(.routeAction(id: _, action: .settingView(.popToProfileRoot))):
                state.routes.popToRoot()
                break
            default:
                break
            
            }
            
            return .none
            
        }.forEachRoute(\.routes, action: \.router)
    }
}
