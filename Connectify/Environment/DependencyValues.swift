//
//  DependencyValues.swift
//  Connectify
//
//  Created by James on 8/7/24.
//

import Dependencies

extension DependencyValues {
	var signClient: SignClient {
		get { self[SignClient.self] }
		set { self[SignClient.self] = newValue }
	}
	
	var homeClient: HomeClient {
		get { self[HomeClient.self] }
		set { self[HomeClient.self] = newValue }
	}
}

public protocol ConectifyDependencyKey: DependencyKey {
	static var liveValue: Value { get }
	associatedtype Value = Self
	static var previewValue: Value { get }
	//static var testValue: Value { get }

}
