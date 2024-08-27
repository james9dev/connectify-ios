//
//  HomeView.swift
//  Connectify
//
//  Created by James on 8/10/24.
//

import SwiftUI
import ComposableArchitecture
import Kingfisher

struct HomeView: View {
	
	@State var store: StoreOf<HomeFeature>
	
    var body: some View {
		ZStack {
			
//			LinearGradient(gradient: Gradient(colors: [Color(red:1.000, green:0.271, blue:0.227), Color(red: 0.993, green: 0.182, blue: 0.472)]), startPoint: .top, endPoint: .bottom).opacity(1.0)
		
			Color(red: 0.945, green: 0.945, blue: 0.945).edgesIgnoringSafeArea(.all)
			
			VStack(alignment: .leading, spacing: 0) {
				
				Spacer()
					.frame(height: 70)
				
				Text(Localized.app_name)
					.font(.title)
					.fontWeight(.semibold)
					.padding([.leading, .trailing], 10)
				
				ScrollView(.horizontal, showsIndicators: true) {
					
					LazyHStack(spacing: 10) {
						
						ForEach(store.state.introMembers) { member in
							
							let imgUrl = (member.profile?.pictures?.first?.imageUrl?.removingPercentEncoding ?? "")
														
							KFImage(URL(string: imgUrl))
								.resizable()
								.scaledToFill()
								.frame(width: 80, height: 80)
								//.blur(radius: 20.0)
								.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
								.onTapGesture {
									store.send(.introMemberTapped(member))
								}
						}
					}
					.frame(height: 100)
					.padding([.leading, .trailing], 10)
				}
				
				Spacer().frame(height: 10)
				
				ScrollView(.vertical, showsIndicators: true) {
										
					MemberProfileView(store: self.store)
						
				} //end ScrollViews
				.clipped()
				
			}
		}//end ZStack
		.edgesIgnoringSafeArea(.top)
		.onAppear {
			store.send(.onAppear)
		}
    }
}

#Preview {
	HomeView(store: Store(initialState: HomeFeature.State()) {
		HomeFeature()
	})
}
