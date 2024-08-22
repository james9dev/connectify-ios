//
//  ProfileView.swift
//  Connectify
//
//  Created by James on 7/20/24.
//

import SwiftUI
import ComposableArchitecture
import GoogleMobileAds

struct ProfileView: View {
	var width: CGFloat = UIScreen.main.bounds.width

	var size: CGSize {
		return GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(width).size
	}
    
    var store: StoreOf<ProfileFeature>
        
    var body: some View {
        VStack {
			
			HStack {
				BannerView(adUnitID: store.state.adUnitID)
					.frame(height: size.height)
					.background(Color.red)
			}

			
			Spacer()
			
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
