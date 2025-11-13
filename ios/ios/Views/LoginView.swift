//
//  LoginView.swift
//  ios
//
//  Created by 駒田隆人 on 2025/10/26.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginModel = LoginViewModel()
    var body: some View {
            VStack(spacing: 24){
                Text("ログイン")
                    .font(.largeTitle)
                    .bold()
                TextField("メールアドレス", text: $loginModel.email)
                    .autocorrectionDisabled(true)
                    .textContentType(.emailAddress)
                    .padding()
                    .cornerRadius(8)
                SecureField("パスワード", text: $loginModel.password)
                    .padding()
                    .cornerRadius(8)
                
                if let error = loginModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                Button(action: {Task{await loginModel.login()}
                }){
                    if loginModel.isLoading{
                        ProgressView()
                    }else{
                        Text("登録")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }
                .disabled(loginModel.isLoading)
            }
            .padding()
            .navigationTitle("新規登録")
    }
}
