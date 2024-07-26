//
//  KakaoView.swift
//  Connectify
//
//  Created by James on 7/23/24.
//

import SwiftUI
import ComposableArchitecture

struct KakaoView: View {
    
    @State var store: StoreOf<SignFeature>
    
    var body: some View {
        Text("Kakao Talk")
    }
}

#Preview {
    KakaoView(store: Store(initialState: SignFeature.State()) {
        SignFeature()
    })
}
