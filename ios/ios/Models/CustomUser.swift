//
//  CustomUser.swift
//  ios
//
//  Created by 駒田隆人 on 2025/10/26.
//

import Foundation

struct CustomUser: Identifiable, Codable{
    let id: UUID
    let email: String
    let first_name: String?
    let last_name: String?
    let avatar: String?
    let icon: String?
    let nickname: String?
    
    var FullName: String{
        return [first_name, last_name].compactMap { $0 }.joined(separator: " ")
    }
    var displayName: String{
        return nickname ?? email
    }
}
