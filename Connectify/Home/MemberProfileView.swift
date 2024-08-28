//
//  MemberProfileView.swift
//  Connectify
//
//  Created by James on 8/27/24.
//

import SwiftUI
import ComposableArchitecture
import Kingfisher

struct MemberProfileView: View {
	
	@State var store: StoreOf<HomeFeature>
	
    var body: some View {
		
		VStack(spacing: 20) {
			ZStack(alignment: .center) {
				GeometryReader { proxy in
					KFImage(URL(string: (store.state.selectedMember?.profile?.getPictureUrl(index: 0) ?? "")))
						.resizable()
						.scaledToFill()
						.frame(width: proxy.size.width)
				}
				
				
				VStack(alignment: .leading) {
					Spacer()
					
					HStack {
						
						Spacer().frame(width: 10)
						
						VStack(alignment: .leading) {
							Spacer().frame(height: 20)
							
							if store.state.selectedMember?.newbie == true {
								Text("New here")
									.foregroundColor(.yellow)
							}
							
							
							Text("\(store.state.selectedMember?.profile?.nickName ?? ""), \(store.state.selectedMember?.profile?.age() ?? 0) ✅")
								.lineLimit(1)
								.font(.title)
								.bold()
								.foregroundColor(.white)
							
							HStack(spacing: 0) {
								if let job = store.state.selectedMember?.profile?.job {
									Text("💼 \(job)")
										.lineLimit(1)
										.foregroundColor(.white)
								}
								
								if let company = store.state.selectedMember?.profile?.company {
									Text(", \(company)")
										.lineLimit(1)
										.foregroundColor(.white)
								}
								
								Spacer().frame(width: 8)
								
								if let location = store.state.selectedMember?.profile?.location {
									Text("🏠 \(location)")
										.lineLimit(1)
										.foregroundColor(.white)
								}
							}
							
							if let educationInstitution = store.state.selectedMember?.profile?.educationInstitution {
								Text("🎓 \(educationInstitution)")
									.lineLimit(1)
									.foregroundColor(.white)
							}
							
							
							Spacer().frame(height: 10)
						}
						
						Spacer()
						
						Spacer().frame(width: 70)
					}
					.background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom))
				}
				
				GeometryReader { proxy in
					Button(action: {
						store.send(.likeButtonTapped)
					}) {
						
						Image("icon_like")
							.aspectRatio(contentMode: .fit)
							.frame(width: 60, height: 60)
							
					}
					.frame(width: 60, height: 60)
					.background(Color.red)
					.clipShape(Circle())
					.position(CGPoint(x: proxy.size.width - 40, y: proxy.size.height - 40))
				}
				
			} //end Z
			.aspectRatio(0.75, contentMode: .fill)
			.cornerRadius(15)
			.padding([.leading, .trailing], 10)
			
			
			if let text = store.state.selectedMember?.profile?.bio {
				HStack {
					VStack(alignment: .leading, spacing: 15) {
						Text("My bio").font(.title3).bold()
						Text(text)
					}
					.padding([.leading, .trailing], 15)
					.padding([.top, .bottom], 30)
					
					Spacer()
				}
				.background(Color.white)
				.cornerRadius(10)
				.padding([.leading, .trailing], 10)
			}
			
			
			if let imgUrl = store.state.selectedMember?.profile?.getPictureUrl(index: 1) {
				VStack {
					GeometryReader { proxy in
						KFImage(URL(string: imgUrl))
							.resizable()
							.scaledToFill()
							.frame(width: proxy.size.width)
					}
				}
				.aspectRatio(0.75, contentMode: .fill)
				.cornerRadius(15)
				.padding([.leading, .trailing], 10)
			}
			
			HStack {
				FlexibleChipsView(verticalSpacing: 10, horizontalSpacing: 10, color: Color(red: 0.945, green: 0.945, blue: 0.945), items: [
					.init(title: "🐕 Dogs"),
					.init(title: "🎾 Tennis", priority: 1),
					.init(title: "🍷 Wine", priority: 2),
					.init(title: "☕️ Coffe", priority: 3),
					.init(title: "🏕️ Camping", priority: 4),
					.init(title: "✈️ Travel", priority: 5),
					.init(title: "✍️ Creativity", priority: 6)
				])
				.padding([.leading, .trailing], 15)
				.padding([.top, .bottom], 15)
			}
			.background(Color.white)
			.cornerRadius(10)
			.padding([.leading, .trailing], 10)
			
			if let imgUrl = store.state.selectedMember?.profile?.getPictureUrl(index: 2) {
				VStack {
					GeometryReader { proxy in
						KFImage(URL(string: imgUrl))
							.resizable()
							.scaledToFill()
							.frame(width: proxy.size.width)
					}
				}
				.aspectRatio(0.75, contentMode: .fill)
				.cornerRadius(15)
				.padding([.leading, .trailing], 10)
			}
			
			if let imgUrl = store.state.selectedMember?.profile?.getPictureUrl(index: 3) {
				VStack {
					GeometryReader { proxy in
						KFImage(URL(string: imgUrl))
							.resizable()
							.scaledToFill()
							.frame(width: proxy.size.width)
					}
				}
				.aspectRatio(0.75, contentMode: .fill)
				.cornerRadius(15)
				.padding([.leading, .trailing], 10)
			}
			
			HStack {
				
				Spacer()
				
				Button(action: {
					store.send(.messageButtonTapped)
				}) {
					
					Image("icon_love_letter")
						.resizable()
						.frame(width: 50, height: 50)
						.aspectRatio(contentMode: .fit)
						
				}
				.frame(width: 60, height: 60)
				.background(Color.yellow)
				.clipShape(Circle())
				.shadow(radius: 10, x: 8, y: 8)
				
				Spacer().frame(width: 40)
				
				Button(action: {
					store.send(.likeButtonTapped)
				}) {
					
					Image("icon_like")
						.aspectRatio(contentMode: .fit)
						.frame(width: 60, height: 60)
						
				}
				.frame(width: 60, height: 60)
				.background(Color.red)
				.clipShape(Circle())
				.shadow(radius: 10, x: 8, y: 8)
				
				Spacer()
			}
			
			Spacer().frame(height: 40)
			
			
		} //end V
    }
}

//#Preview {
//	MemberProfileView(store: Store(initialState: HomeFeature.State()) {
//		HomeFeature()
//	})
//}
