//
//  AuthToken.swift
//  ios
//
//  Created by 駒田隆人 on 2025/10/26.
//

import Foundation
nonisolated
struct AuthToken: Codable, Sendable{
    let access: String
    let refresh: String
}
