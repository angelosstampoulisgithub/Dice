//
//  ContentView.swift
//  Dice
//
//  Created by Angelos Staboulis on 10/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var rollTrigger = false

    var body: some View {
        Color.black.overlay {
            VStack(spacing: 20) {
                        DiceSceneView(rollTrigger: $rollTrigger)
                            .frame(width: 300, height: 300)
                            .cornerRadius(16)

                        Button(action: {
                            rollTrigger = true
                        }) {
                            Text("Roll Dice")
                                .font(.title2)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                }
                    .ignoresSafeArea()
        }
       
             
        
    }
    
    
}

#Preview {
    ContentView()
}
