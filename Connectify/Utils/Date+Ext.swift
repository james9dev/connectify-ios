//
//  Date+Ext.swift
//  Connectify
//
//  Created by James on 8/27/24.
//

import Foundation

extension Date {
		
	func getAge(string: String, format: String?) -> Int? {
		
		guard let selectDate = self.getBirthdayDate(string: string, format: format) else {
			return nil
		}
		
		let dateComponents = DateComponentsFormatter()
		dateComponents.allowedUnits = [.year]
		dateComponents.unitsStyle = .full
		
		if let yearString = dateComponents.string(from: selectDate, to: Date()) {
			
			if yearString.hasPrefix("-") {
				return nil;
			}
			
			let digitSet = CharacterSet.decimalDigits
			
			var tmpAge: String = String()
			for (_, ch) in yearString.unicodeScalars.enumerated() {
				if digitSet.contains(ch) {
					tmpAge = "\(tmpAge)\(ch)"
				}
			}
			
			return Int.init(tmpAge) ?? nil
		}
		
		return nil
	}
	
	private func getBirthdayDate(string: String, format: String?) -> Date? {
		
		guard let format = format else {
			return nil
		}
		
		if string.isEmpty == true {
			return nil
		}

		
		let dateString: String = string
		
		let dateFormatter = DateFormatter()
		
		dateFormatter.dateFormat = format
		
		let date: Date? = dateFormatter.date(from: dateString)
		
		return date
	}
}
