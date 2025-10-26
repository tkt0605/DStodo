//
//  SignupRequest.swift
//  ios
//
//  Created by 駒田隆人 on 2025/10/26.
//

import Foundation

struct SignupRequest: Codable{
    let email: String
    let password: String
    let nickname: String
}
