//
//  ThinkingIndicator.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import SwiftUI

struct ThinkingIndicator: View {
    @State private var scale: CGFloat = 0.8

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<3) { i in
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.cyan)
                    .scaleEffect(scale)
                    .animation(
                        .easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(i) * 0.2),
                        value: scale
                    )
            }
        }
        .onAppear { scale = 1.2 }
    }
}
