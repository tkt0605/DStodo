//
//  ChatInputBar.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import SwiftUI

struct ChatInputBar: View {
    @Binding var text: String
    var onSend: () -> Void
    
    var body: some View {
        HStack {
            TextField("メッセージを入力…", text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Button(action: onSend) {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.cyan)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal)
    }
}
