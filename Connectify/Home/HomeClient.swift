//
//  HomeClient.swift
//  Connectify
//
//  Created by James on 8/27/24.
//

import Foundation

struct HomeClient {
	var introMembers: @Sendable () async throws -> ResultDto<ListDto<Member>>
}

extension HomeClient: ConectifyDependencyKey {
	
	static let liveValue = Self.Value(
		introMembers: {
			let url = APIUrl.main("/match/intro")
			return await APIClient<ListDto<Member>>.request(url, method: .get, parameters: nil)
		})
}
