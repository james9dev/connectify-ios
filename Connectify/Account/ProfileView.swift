//
//  ProfileView.swift
//  Connectify
//
//  Created by James on 7/20/24.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    
    var store: StoreOf<ProfileFeature>
        
    var body: some View {
        VStack {
            Button(action: { store.send(.signoutButtonTapped) }) {
                Text("Signout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.red)
                    .cornerRadius(15.0)
            }
            
            Button(action: { store.send(.settingButtonTapped) }) {
                Text("Setting")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.red)
                    .cornerRadius(15.0)
            }
        }
        .padding()
    }
}

#Preview {
    ProfileView(store: Store(initialState: ProfileFeature.State()) {
        ProfileFeature()
    })
}
