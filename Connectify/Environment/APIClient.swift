//
//  APIClient.swift
//  Connectify
//
//  Created by James on 8/7/24.
//

import Foundation
import Alamofire

enum APIUrl<String> {
	
	case main(String)
	case file(String)
	case sub(String)
	
		
	var absoluteString: String {
		
		var convertible = ""
		switch self {
		case .main(let path):
			convertible = "http://localhost:8080\(path)"
		case .file(let path):
			convertible = "https://connectify-files-origin.s3.ap-northeast-2.amazonaws.com\(path)"
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
			
			let headers: HTTPHeaders? = headers ?? ["Content-Type":"application/json", "Accept":"*/*"]
			
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
										
					if let data, let result = try? JSONDecoder().decode(ResultDto<T>.self, from: data) {
						continuation.resume(returning: result)
					} else {
						let result = ResultDto<T>.init(resultCode: 499, message: "JSONDeocder error")
						continuation.resume(returning: result)
					}

				case .failure(let error):
					
					if let data = response.data, let result = try? JSONDecoder().decode(ResultDto<T>.self, from: data) {
						continuation.resume(returning: result)
					} else  {
						let result = ResultDto<T>.init(resultCode: error.responseCode ?? 500, message: error.errorDescription ?? "")
						continuation.resume(returning: result)
					}
				}
			}
		}
	}
}
