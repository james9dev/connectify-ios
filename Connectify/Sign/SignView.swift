//
//  SignView.swift
//  Connectify
//
//  Created by James on 7/20/24.
//

import SwiftUI
import ComposableArchitecture
import KakaoSDKAuth

struct SignView: View {
    
    @State var store: StoreOf<SignFeature>
    
    let background = Color.gray
    
    var body: some View {
        
        ZStack {
			
			LinearGradient(gradient: Gradient(colors: [Color(red:1.000, green:0.271, blue:0.227), Color(red: 0.993, green: 0.182, blue: 0.472)]), startPoint: .top, endPoint: .bottom)
			
            VStack {
                /*
                TextField("Username", text: $store.username)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                    .padding(.top, 100)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $store.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(5.0)
                
                Button(action: { store.send(.signinButtonTapped) }) {
                    Text("Signin")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }*/
				
				Spacer().frame(height: 80)
				
				HStack {
					Spacer()
					Image("sample_sign_1")
						.resizable()
						.scaledToFill()
						.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
						.frame(width: 60, height: 60)
					Spacer().frame(width: 30)
				}
				
				Image("sample_sign_0")
					.resizable()
					.scaledToFill()
					.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
					.frame(width: 100, height: 100)
				
				HStack {
					Spacer().frame(width: 30)
					Image("sample_sign_2")
						.resizable()
						.scaledToFill()
						.clipShape(Circle())
						.frame(width: 70, height: 70)
					Spacer()
				}
				
				HStack {
					Spacer()
					Image("sample_sign_3")
						.resizable()
						.scaledToFill()
						.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
						.frame(width: 60, height: 60)
					Spacer().frame(width: 80)
				}
				
                
                Spacer()				
				
				HStack {
					Spacer()
					Text("Find your Perfect Love!")
						.font(.system(size: 22, weight: .regular))
						.foregroundColor(.white)
						.multilineTextAlignment(.trailing)
						.padding(.bottom, 10)
				}
				
				HStack {
					Spacer()
					Text("Don't quit.\nStay here as a couple!")
						.font(.system(size: 44, weight: .bold))
						.minimumScaleFactor(0.1)
						.lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
						.foregroundColor(.white)
						.multilineTextAlignment(.trailing)
						.padding(.bottom, 20)
				}
                
                Button(action: {
                    store.send(.kakaoButtonTapped)
                }) {
                    
                    Image("kakao_login_medium_narrow")
                        .frame(width: 183, height: 45)                    
                }
				.padding(.bottom, 80)
				.alert(store.state.signFailMessage, isPresented: $store.state.signFailAlert) {
					Button("OK", role: .cancel) { }
				}
                
            }
            .padding()
            
        }
        .edgesIgnoringSafeArea(.all)
        .onOpenURL { url in
            print("URL: \(url)")
            
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.handleOpenUrl(url: url)
            }
        }
    }
}

#Preview {
    SignView(store: Store(initialState: SignFeature.State()) {
        SignFeature()
    })
}
