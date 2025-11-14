//
//  ChatMessage.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import Foundation

struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}
