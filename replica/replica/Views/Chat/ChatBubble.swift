//
//  ChatBubble.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import SwiftUI

struct ChatBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            Text(message.text)
                .padding()
                .foregroundColor(message.isUser ? .white : .black)
                .background(
                    message.isUser
                    ? LinearGradient(colors: [.cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing)
                    : Color(.systemGray5)
                )
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .frame(maxWidth: 260, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser { Spacer() }
        }
        .padding(.horizontal)
    }
}
