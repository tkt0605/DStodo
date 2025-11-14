//
//  ChatView.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var vm = ChatViewModel()
    @State private var newMessage = ""

    var body: some View {
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 16) {
                        ForEach(vm.messages) { message in
                            ChatBubble(message: message)
                                .id(message.id)
                        }
                    }
                }
                .onChange(of: vm.messages.count) { _ in
                    withAnimation {
                        proxy.scrollTo(vm.messages.last?.id)
                    }
                }
            }

            ChatInputBar(text: $newMessage) {
                vm.sendUserMessage(newMessage)
                newMessage = ""
            }
            .padding(.bottom)
        }
        .navigationTitle("AI Chat")
        .navigationBarTitleDisplayMode(.inline)
    }
}
