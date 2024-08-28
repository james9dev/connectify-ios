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
				
		var introMembers: [Member] = []
		var selectedMember: Member? = nil
	}

	enum Action {
		case onAppear
		case setIntroMembers(_ values: [Member])
		
		case introMemberTapped(_ member: Member)
		
		case likeButtonTapped
		case messageButtonTapped
		case passButtonTapped
	}
	
	@Dependency(\.homeClient) var client

	// Reducer
	var body: some ReducerOf<Self> {
			
		Reduce { state, action in
			switch action {
			case .onAppear:
				return .run { send in
										
					let result = try await client.introMembers()
					
					if result.success(), let members = result.data?.values {
						await send(.setIntroMembers(members))
					} else {
						//await send(.signnedFail(result.message))
					}
				}
			case .setIntroMembers(let members):
				state.introMembers = members
				state.selectedMember = members.first
				break
				
			case .introMemberTapped(let member):
				state.selectedMember = member
				break
			case .likeButtonTapped:
				
				break
			case .messageButtonTapped:
				
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
