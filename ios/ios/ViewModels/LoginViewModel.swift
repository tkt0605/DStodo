//
//  CustomUser.swift
//  ios
//
//  Created by 駒田隆人 on 2025/10/26.
//

import Foundation
import SwiftUI
internal import Combine

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    @Published var loginSuccess = false
    func login() async {
        DispatchQueue.main.async {
            self.isLoading = true
            self.errorMessage = nil
        }
        AuthAPI.loginAsync(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                //AuthAPIでのloginAsyncでの処理を実行後にて成功・失敗の処理の切り替えし
                switch result {
                    //成功後の処理
                case .success(let token):
                    KeychainHelper.shared.save(token.access, service: "access-token", account: "user")
                    KeychainHelper.shared.save(token.refresh, service: "refresh-token", account: "user")
                    print("ログイン成功: \(token.access)")
                    self.loginSuccess = true
                    // TODO: トップ画面遷移など
                    //失敗後の処理
                case .failure(let error):
                    self.errorMessage = "ログイン失敗: \(error.localizedDescription)"
                }
            }
        }
    }
}
    
