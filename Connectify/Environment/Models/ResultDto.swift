//
//  Models.swift
//  Connectify
//
//  Created by James on 8/7/24.
//

import Foundation

struct ResultDto<T: Codable>: Codable {
	let resultCode: Int
	let message: String
	let data: T?
	
	func success() -> Bool {
		return 200 <= resultCode && resultCode <= 299
	}
	
	init(resultCode: Int, message: String) {
		self.resultCode = resultCode
		self.message = message
		self.data = nil
	}
}

struct ListDto<T: Codable>: Codable {
	let size: Int
	let total: Int
	let data: [T]
}


struct AuthTokenDto: Codable {
	let authType: AuthType
	let accessToken: String
	let refreshToken: String
	
	
	enum AuthType: String, Codable {
		case SignIn
		case SignUp
		case Refresh
	}
}
