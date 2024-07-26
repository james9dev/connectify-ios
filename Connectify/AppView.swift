//
//  SignView.swift
//  Connectify
//
//  Created by James on 7/20/24.
//

import SwiftUI
import ComposableArchitecture
import Combine

struct AppView: View {
    
    let store: StoreOf<AppFeature>
    
    let cancelBag = CancelBag()

        
    var body: some View {
        
        WithPerceptionTracking {
            VStack {
                if store.isSignnedIn {
                    MainCoordinatorView(store: store.scope(state: \.mainS, action: \.mainA))
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                } else {
                    SignCoordinatorView(store: store.scope(state: \.signS, action: \.signA))
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
            .task {
                
                GlobalEventService.service.signedOutPublisher.receive(on: DispatchQueue.main).sink { _ in
                    store.send(.signout)
                }.store(in: cancelBag)
            }
        }
    }
}

#Preview {
    SignView(store: Store(initialState: SignFeature.State()) {
        SignFeature()
    })
}
