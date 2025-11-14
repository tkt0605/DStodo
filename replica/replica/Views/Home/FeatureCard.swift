//
//  FeatureCard.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import SwiftUI

struct FeatureCard: View {
    let item: FeatureItem
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: item.icon)
                .font(.system(size: 30))
                .foregroundColor(.white)
                .padding()
                .background(item.color.opacity(0.8))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text(item.title)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.black.opacity(0.2))
                .background(.ultraThinMaterial)
        )
    }
}
