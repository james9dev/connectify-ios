//
//  SettingView.swift
//  Connectify
//
//  Created by James on 7/20/24.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {
    
    var store: StoreOf<SettingFeature>
        
    var body: some View {
        VStack {            
            Button(action: { store.send(.popToRootButtonTapped) }) {
                
                Text("Pop to root")
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
