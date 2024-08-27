//
//  String+Ext.swift
//  Connectify
//
//  Created by James on 8/27/24.
//

import Foundation

extension String {
	var localized: String {
		return self.localize()
	}
	
	func localize(comment: String = "") -> String {
		var str = NSLocalizedString(self, comment: comment)
		
		if str == self || str == "" {
			let path = Bundle.main.path(forResource: "en", ofType: "lproj")
			let bundle = Bundle(path: path!)!
			str = NSLocalizedString(self, bundle: bundle, comment: comment)
		}
		
		return str
	}
}
