//
//  TodoItem.swift
//  ios
//
//  Created by 駒田隆人 on 2025/10/26.
//

import Foundation

struct TodoItem: Identifiable, Codable, Sendable{
    let id: UUID
    var title: String
    var nemo: String
    var is_completed: Bool
    var created_at: String
    var updated_at: String
    
}
