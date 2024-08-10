//
//  KakaoClient.swift
//  Connectify
//
//  Created by James on 8/7/24.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

struct KakaoAPI {
	static func kakaoLogin() async -> (String?, Error?) {
	
		return await withCheckedContinuation { continuation in

			if UserApi.isKakaoTalkLoginAvailable() {

				UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
					if let error = error as? KakaoSDKCommon.SdkError {
						print(error)
					}
					
					if let accessToken = oauthToken?.accessToken {
						print("loginWithKakaoAccount() success: \(accessToken)")
					}
					
					continuation.resume(returning: (oauthToken?.accessToken, error))
				}
				
			} else {
				
				UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
					if let error = error as? KakaoSDKCommon.SdkError {
						print(error)
						
					}
					
					if let accessToken = oauthToken?.accessToken {
						print("loginWithKakaoAccount() success: \(accessToken)")
					}
					
					continuation.resume(returning: (oauthToken?.accessToken, error))
				}
			}
		}
	}
}
