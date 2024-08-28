//
//  MemberDto.swift
//  Connectify
//
//  Created by James on 8/29/24.
//

import Foundation

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
	
	func getPictureUrl(index: Int) -> String? {
		if (pictures?.count ?? 0) > index {
			return pictures?[index].imageUrl?.removingPercentEncoding
		}
		
		return nil
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
