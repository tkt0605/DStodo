//
//  SignupViewModel.swift
//  ios
//
//  Created by 駒田隆人 on 2025/10/26.
//

import Foundation
import SwiftUI
internal import Combine

class SignupViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    @Published var nickname = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func signup() async{
        DispatchQueue.main.async{
            self.isLoading = true
            self.errorMessage = nil
        }
        AuthAPI.signup(email: email, password: password, nickname: nickname){ result in
            DispatchQueue.main.async{
                self.isLoading = false
                switch result {
                case .success(let token):
                    KeychainHelper.shared.save(token.access, service: "access-token", account: "user")
                    KeychainHelper.shared.save(token.refresh, service: "refresh-token", account: "user")
                    print("サインアップ成功: \(token.access)")
                case .failure(let error):
                    self.errorMessage = "サインアップ失敗: \(error.localizedDescription)"
                }
            }
        }
    }
}
