//
//  MainCoordinator.swift
//  Connectify
//
//  Created by James on 7/22/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct MainCoordinatorView: View {
	@Perception.Bindable var store: StoreOf<MainCoordinator>
    
	var body: some View {
		WithPerceptionTracking {
			TabView(selection: $store.selectedTab.sending(\.tabSelected)) {
                Text("Home")
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
					.tag(MainCoordinator.Tab.tab1)

                Text("Search")
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
					.tag(MainCoordinator.Tab.tab2)

                Text("Notifications")
                    .tabItem {
                        Image(systemName: "bell.fill")
                        Text("Notifications")
                    }
					.tag(MainCoordinator.Tab.tab3)

                AccountCoordinatorView(store: store.scope(state: \.profile, action: \.profile))
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
					.tag(MainCoordinator.Tab.tab4)
            }
        }
    }
}

@Reducer
struct MainCoordinator {
    
    enum Tab: Hashable {
      case tab1, tab2, tab3, tab4, deeplinkOpened
    }

    enum Deeplink {
        //case identified(IdentifiedCoordinator.Deeplink)
    }

	@ObservableState
	struct State: Equatable {
		
		static let initialState = MainCoordinator.State(profile: .initialState, selectedTab: .tab1)
        
//    var identified: IdentifiedCoordinator.State
//    var indexed: IndexedCoordinator.State
//    var app: GameApp.State
//    var form: FormAppCoordinator.State
        
		var profile: AccountCoordinator.State
		var selectedTab: Tab
	}

    enum Action {
        //case deeplinkOpened(Deeplink)
		case profile(AccountCoordinator.Action)
		case signout
		case tabSelected(Tab)
	}
	
	var body: some ReducerOf<Self> {
		
		Scope(state: \.profile, action: \.profile) {
			AccountCoordinator()
		}
      
		Reduce { state, action in
            switch action {
      
//      case let .deeplinkOpened(.identified(.showNumber(number))):
//        state.selectedTab = .identified
//        if state.identified.routes.canPush == true {
//          state.identified.routes.push(.numberDetail(.init(number: number)))
//        } else {
//          state.identified.routes.presentSheet(.numberDetail(.init(number: number)), embedInNavigationView: true)
//        }

				
			case .profile(.router(.routeAction(_, .profileView(.signoutButtonTapped)))):
				
//				return .run { [] send in
//					 
//					await send(.signout)
//				 
//			   }
				
				break
            case let .tabSelected(tab):
                state.selectedTab = tab
      
            default:
				break
			}
        
			return .none
		}
	}
}
