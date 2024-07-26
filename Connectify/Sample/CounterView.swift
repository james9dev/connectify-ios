//
//  CounterView.swift
//  Connectify
//
//  Created by James on 7/18/24.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    
    let store: StoreOf<CounterFeature>
    
    var body: some View {
        VStack {
            
            Text("\(store.count)")
            
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
            }
                        
            Button("Fact") {
                store.send(.factButtonTapped)
            }
            
            if store.isLoading {
                ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            
            Button(store.isTimerRunning ? "Stop timer" : "Start timer") {
                store.send(.toggleTimerButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
        }
    }
}

#Preview {
    CounterView(store: Store(initialState: CounterFeature.State()) {
        CounterFeature()        
    })
}
