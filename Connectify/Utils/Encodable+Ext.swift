//
//  Encodable+Ext.swift
//  Connectify
//
//  Created by James on 8/10/24.
//

import Foundation

extension Encodable {
	
	var toDictionary : [String: Any]? {
		guard let object = try? JSONEncoder().encode(self) else {
			return nil
		}
		
		guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:Any] else {
			return nil
		}
		
		return dictionary
	}
	
	var toJsonString: String? {
		
		do {
			let jsonData = try JSONEncoder().encode(self)
			let json = String(data: jsonData, encoding: .utf8)
			
			return json
		} catch let error {
			print("Error - Encodable toJsonString: \(error.localizedDescription)")
			return nil
		}
	}
	
	
}
