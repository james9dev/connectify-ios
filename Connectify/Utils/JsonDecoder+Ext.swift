//
//  JsonDecoder+Ext.swift
//  Connectify
//
//  Created by James on 8/10/24.
//

import Foundation

extension JSONDecoder {
	
	func decode<T>(_ type: T.Type, from dictionary: [String: Any]) -> T? where T: Decodable {
		
		do {
			if let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
				return try decode(T.self, from: data )
			}
		} catch let error as NSError {
			print("JSONDecoder.decode error: \(error)")
			return nil
		}
		
		return nil
	}
	
	func stringDecode<T>(_ type: T.Type, from string: String?, logging: Bool = false) -> T? where T: Decodable {
		
		guard let string = string else {
			return nil
		}
		
		do {
			if let data: Data = string.data(using: .utf8),
				let dictionary = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String:AnyObject],
				let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
				
				#if DEBUG
				if logging == true {
					print("String decode: dictionary - \(dictionary)")
				}
				#endif
				
				return try decode(T.self, from: data )
			}
		} catch let error as NSError {
			print("JSONDecoder.decode error: \(error)")
			return nil
		}
		
		return nil
	}
	
	
}
