//
//  AIService.swift
//  replica
//
//  Created by 駒田隆人 on 2025/11/14.
//

import Foundation

class AIService {
    static let shared = AIService()

    func generateReply(to text: String) async -> String {
        // TODO: OpenAI / LLaMA / 自作AIにつなぐ
        try? await Task.sleep(nanoseconds: 800_000_000)
        return "AIの返信: \(text)"
    }
}
