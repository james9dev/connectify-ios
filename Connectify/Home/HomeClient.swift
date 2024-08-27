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


//struct RequestMatchIntroMembers: Codable {
//	var accessToken: String
//}


struct Member: Codable, Equatable, Identifiable {
	let id: Double?
	let createdAt: String?
	let newbie: Bool?
	let email: String?
	let name: String?
	let phoneNumber: String?
	let profile: Profile?
	
}

struct Profile: Codable, Equatable {
	let id: Double?
	
	let nickName: String?
	let birthyear: String?
	let birthday: String?
	
	let gender: GenderType?
	let height: Int?
	
	let job: String?
	let company: String?
	let educationInstitution: String?
	let educationGraduation: String?
			
	let latitude: Double?
	let longitude: Double?
	let location: String?
	
	let bio: String?
	
	let pictures: [ProfilePicture]?
	
	func age() -> Int? {
		
		let birdthDate = "\(birthyear ?? "")-\(birthday ?? "")"
		
		return Date().getAge(string: birdthDate, format: "YYYY-MMdd")
		
	}
	
}

struct ProfilePicture: Codable, Equatable {
	let id: Double?
	let imageUrl: String?
	let order: Int?
	let createdAt: String?
}

enum GenderType: String, Codable {
	case MALE
	case FEMALE
}
