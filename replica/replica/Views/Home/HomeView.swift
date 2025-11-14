//
//  HomeView.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import SwiftUI

struct HomeView: View {
    let features = [
        FeatureItem(title: "AI Chat", icon: "message.fill", color: .cyan),
        FeatureItem(title: "Voice Chat", icon: "mic.fill", color: .purple),
        FeatureItem(title: "Image Generate", icon: "sparkles", color: .pink),
        FeatureItem(title: "Settings", icon: "gearshape.fill", color: .gray)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    GradientTitle(text: "Replica AI")
                        .padding(.top, 20)

                    Text("Choose a feature")
                        .foregroundColor(.gray)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(features) { item in
                            NavigationLink(destination: ChatView()) {
                                FeatureCard(item: item)
                            }
                        }
                    }
                    .padding(.top)
                }
                .padding()
            }
        }
    }
}
