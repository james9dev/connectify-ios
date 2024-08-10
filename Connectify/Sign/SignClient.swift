//
//  SignClient.swift
//  Connectify
//
//  Created by James on 8/7/24.
//

struct SignClient {
	var loginWithKakaoTalk: @Sendable () async throws -> (accessToken: String?, error: Error?)
	var signWithKakao: @Sendable (_ accessToken: String) async throws -> ResultDto<AuthTokenDto>
}

extension SignClient: ConectifyDependencyKey {
	
	static let liveValue = Self.Value(
		loginWithKakaoTalk: {
			return await KakaoAPI.kakaoLogin()
		},
		signWithKakao: { accessToken in
			let url = APIUrl.main("/member/sign/kakao")
			let param = RequestSignKakao(accessToken: accessToken).toDictionary
			
			return await APIClient<AuthTokenDto>.request(url, method: .post, parameters: param)
		})
}


struct RequestSignKakao: Codable {
	var accessToken: String
}
