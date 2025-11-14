//
//  ChatViewModel.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import SwiftUI

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [
        ChatMessage(text: "こんにちは！何をお手伝いしましょうか？", isUser: false)
    ]

    func sendUserMessage(_ text: String) {
        guard !text.isEmpty else { return }

        let userMsg = ChatMessage(text: text, isUser: true)
        messages.append(userMsg)

        Task {
            let aiResponse = await AIService.shared.generateReply(to: text)
            DispatchQueue.main.async {
                self.messages.append(ChatMessage(text: aiResponse, isUser: false))
            }
        }
    }
}
