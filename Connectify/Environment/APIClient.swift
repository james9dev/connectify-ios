//
//  APIClient.swift
//  Connectify
//
//  Created by James on 8/7/24.
//

import Foundation
import Alamofire

extension Bundle {
	
	var apiServer: String {
		
		var key = ""
		
		#if LOCAL
		key = "API_URL_LOCAL"
		#elseif DEBUG
		key = "API_URL_DEBUG"
		#else
		key = "API_URL_RELEASE"
		#endif
		
		return self.getValue(key: key)
	}
	
	var s3Server: String {
		
		var key = ""
		
		#if LOCAL
		key = "S3_URL_LOCAL"
		#elseif DEBUG
		key = "S3_URL_DEBUG"
		#else
		key = "S3_URL_RELEASE"
		#endif
		
		return self.getValue(key: key)
	}
	
	func getValue(key: String) -> String {
		guard let filePath = self.path(forResource: "Info", ofType: "plist"),
			  let plistDict = NSDictionary(contentsOfFile: filePath),
			  let value = plistDict.object(forKey: key) as? String else {
			return ""
		}
		
		return value
	}
}

enum APIUrl<String> {
	
	case main(String)
	case file(String)
	case sub(String)
	
		
	var absoluteString: String {
		
		var convertible = ""
		switch self {
		case .main(let path): 
			convertible = Bundle.main.apiServer + "\(path)"
		case .file(let path):
			convertible = Bundle.main.s3Server + "\(path)"
		case .sub(_):
			break
		}
		
		return convertible as! String
	}
}

struct APIClient<T: Codable> {
		
	
	static func request(_ url: APIUrl<String>,
						   method: HTTPMethod = .get,
						   parameters: Parameters? = nil,
						   headers: HTTPHeaders? = nil) async -> ResultDto<T> {
	
		return await withCheckedContinuation { continuation in
			
			let convertible = url.absoluteString
			
			var headers: HTTPHeaders? = headers ?? ["Content-Type":"application/json", "Accept":"*/*"]
			
			if let accessToken = KeychainHelper.read(label: "auth_access_token") {
				headers?.add(name: "Authorization", value: "Bearer \(accessToken)")
			}
			
			AF.request(convertible,
					   method: method,
					   parameters: parameters,
					   encoding: JSONEncoding.default,
					   headers: headers)
			.validate(statusCode: 200..<300)
			.response { response in
				
				if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
					print("---------------------------------------")
					print("")
					print("headers: \(headers ?? [:])")
					print("parameters: \(parameters ?? [:])")
					print("response: \(utf8Text)")
					print("")
					print("---------------------------------------")
				}
				
				switch response.result {
				case .success(let data):
					
					guard let data else {
						let result = ResultDto<T>.init(resultCode: 500, message: "The response value data is empty.")
						continuation.resume(returning: result)
						return
					}
					
					do {
						let result = try JSONDecoder().decode(ResultDto<T>.self, from: data)
						continuation.resume(returning: result)
					} catch {
						print("API Response JSON decode error: \(error)")
						let result = ResultDto<T>.init(resultCode: 499, message: error.localizedDescription)
						continuation.resume(returning: result)
						
					}

				case .failure(let error):
					
					guard let data = response.data else {
						let result = ResultDto<T>.init(resultCode: error.responseCode ?? 500, message: error.errorDescription ?? "")
						continuation.resume(returning: result)
						return
					}
					
					do {
						let result = try JSONDecoder().decode(ResultDto<T>.self, from: data)
						continuation.resume(returning: result)
					} catch {
						print("API Response JSON decode error: \(error)")
						let result = ResultDto<T>.init(resultCode: 499, message: error.localizedDescription)
						continuation.resume(returning: result)
						
					}
				}
			}
		}
	}
}
