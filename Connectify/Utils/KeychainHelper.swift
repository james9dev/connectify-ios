//
//  KeychainHelper.swift
//  Connectify
//
//  Created by James on 8/7/24.
//

import Foundation
import Security

class KeychainHelper {
	
	static let serviceName = Bundle.main.bundleIdentifier ?? ""
	
	public static func isFirstLaunch() -> Bool {
		let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
		let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
		
		if isFirstLaunch {
			UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
			UserDefaults.standard.synchronize()
		}
		
		return isFirstLaunch
	}
	
	@discardableResult
	static func create(value: String, label: String) -> Bool {
		
		let keychainItem = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrLabel: label,
			kSecAttrService: serviceName,
			kSecValueData: value.data(using: .utf8) as Any
		] as [String: Any]
		
		// Add the password to the keychain.
		let status = SecItemAdd(keychainItem as CFDictionary, nil)
		guard status == errSecSuccess else {
			print("Keychain create Error")
			return false
		}
		
		return true
	}
	
	static func read(label: String) -> String? {
		let keychainItem = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrLabel: label,
			kSecAttrService: serviceName,
			kSecReturnData: true
		] as [String: Any]
		
		var item: AnyObject?
		let status = SecItemCopyMatching(keychainItem as CFDictionary, &item)
		if status == errSecSuccess {
			return String(data: item as! Data, encoding: .utf8)
		}
		
		if status == errSecItemNotFound {
			print("The token was not found in keychain")
			return nil
		} else {
			print("Error getting token from keychain: \(status)")
			return nil
		}
	}
	
	@discardableResult
	static func update(value: String, label: String) -> Bool{
		let keychainItem = [
			kSecClass: kSecClassGenericPassword
		] as [String: Any]

		let attributes = [
			kSecAttrService: serviceName,
			kSecAttrLabel: label,
			kSecValueData: value.data(using: .utf8) as Any
		]

		let status = SecItemUpdate(keychainItem as CFDictionary, attributes as CFDictionary)
		guard status != errSecItemNotFound else {
			print("The token was not found in keychain")
			return false
		}
		guard status == errSecSuccess else {
			print("Keychain update Error")
			return false
		}
		
		print("The token in keychain is updated")
		return true
	}
	
	@discardableResult
	static func delete(label: String) -> Bool{
		let keychainItem = [
			kSecClass: kSecClassGenericPassword,
			kSecAttrService: serviceName,
			kSecAttrLabel: label
		] as [String: Any]

		let status = SecItemDelete(keychainItem as CFDictionary)
		guard status != errSecItemNotFound else {
			print("The token was not found in keychain")
			return false
		}
		guard status == errSecSuccess else {
			print("Keychain delete Error")
			return false
		}
		
		print("The token in keychain is deleted")
		
		return true
	}


}
