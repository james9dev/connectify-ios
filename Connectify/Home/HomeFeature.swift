//
//  HomeFeature.swift
//  Connectify
//
//  Created by James on 8/26/24.
//

import Foundation
import ComposableArchitecture

@Reducer
struct HomeFeature {
		
	let service = GlobalEventService()
	
	@ObservableState
	struct State: Equatable {
		
		static let initialState = State()
		
		let id = UUID()
		
	}

	enum Action {
		case likeButtonTapped
		case passButtonTapped
	}

	// Environment
//    struct LoginEnvironment {}

	// Reducer
	var body: some ReducerOf<Self> {
			
		Reduce { state, action in
			switch action {

			case .likeButtonTapped:
				
				break
			case .passButtonTapped:
				
				break
			default:
				break
			}
			
			return .none
			
		}
	}
	
}
