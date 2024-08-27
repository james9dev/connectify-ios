//
//  HomeView.swift
//  Connectify
//
//  Created by James on 8/10/24.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    var body: some View {
		ZStack {
			
			LinearGradient(gradient: Gradient(colors: [Color(red:1.000, green:0.271, blue:0.227), Color(red: 0.993, green: 0.182, blue: 0.472)]), startPoint: .top, endPoint: .bottom).opacity(1.0)
			
			VStack {
				Spacer().frame(height: 80)
				
				ScrollView(.horizontal, showsIndicators: true) {
					
					LazyHStack(spacing: 10) {
						ForEach(0..<10) { index in
							KFImage(URL(string:"https://connectify-files-origin.s3.ap-northeast-2.amazonaws.com/profile/sample_profile_\(index).jpg"))
								.resizable()
								.scaledToFill()
								.frame(width: 80, height: 80)
								//.blur(radius: 20.0)
								.clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
								
							
						}
					}
					.frame(height: 100)
					.padding([.leading, .trailing], 10)
				}
				
				Spacer().frame(height: 40)
				
				ScrollView(.vertical, showsIndicators: true) {
					ZStack {
						GeometryReader { proxy in
							KFImage(URL(string:"https://connectify-files-origin.s3.ap-northeast-2.amazonaws.com/profile/sample_profile_0.jpg"))
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

									Text("New here") //새 회원
										.foregroundColor(.yellow)
									
									Text("Linda Camel, 26 ✅")
										.lineLimit(1)
										.font(.title)
										.bold()
										.foregroundColor(.white)
									
									Text("💼 Producer, 🏠 Seoul, Korea")
										.lineLimit(1)
										.foregroundColor(.white)

									Text("🎓 Ewha Womans University")
										.lineLimit(1)
										.foregroundColor(.white)

									Spacer().frame(height: 10)
								}
								
								Spacer()
							}
							.background(LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
							)
						}

					} //end Z
					.aspectRatio(0.75, contentMode: .fill)
					.cornerRadius(15)
					.padding([.leading, .trailing], 10)
					
					
					Spacer().frame(height: 40)
					
					VStack {
						HStack {
							
							let text = "I%20work%20in%20Finance%20and%20can%20work%20anywhere.%20Based%20in%20Tokyo%20and%20Kyoto.%0AI%20wanna%20get%20new%20friends%20in%20the%20world.%20l%27d%20be%20happy%20if%20a%20friend%20would%20be%20my%0ABF%20and%20lead%20to%20marriage.%0ATokyo%20in%2023%20Dec%2C%20Guangzhou%0ACountdown%2C%20Seoul%20in%20Jan%2C%20Japan%20in%20Feb%20and%20March%2C%20and%20Bangkok%20in%20April.%20Seoul%20in%20August%2C%20Bali%20in%20September.".removingPercentEncoding!
							
							Text(text)
								.padding([.leading, .trailing, .top, .bottom], 15)
							
							Spacer()
						}
						.background(Color.white.opacity(0.5))
						.cornerRadius(10)
						
						
					}
					.padding([.leading, .trailing], 10)
					
					Spacer().frame(height: 40)
					
				} //end ScrollViews
				.clipped()
				
			}
		}
		.edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    HomeView()
}
