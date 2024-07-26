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
            LinearGradient(gradient: Gradient(colors: [Color(uiColor: UIColor(red:1.000, green:0.271, blue:0.227, alpha:1.00)), Color.init(uiColor: UIColor(red: 0.993, green: 0.182, blue: 0.472, alpha: 1.0))]), startPoint: .top, endPoint: .bottom)
        
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
                
                Spacer()
                
                Text("Find your\nPerfect Love!")
                    .font(Font.system(size: 50, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    .padding(.bottom, 20)
                
                Button(action: {
                    store.send(.kakaoButtonTapped)
                }) {
                    
                    Image("kakao_login_medium_narrow")
                        .frame(width: 183, height: 45)
                    
//                    Text("With Kakao")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(width: 220, height: 60)
//                        .background(Color.blue)
//                        .cornerRadius(15.0)
                }.padding(.bottom, 100)
                
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
