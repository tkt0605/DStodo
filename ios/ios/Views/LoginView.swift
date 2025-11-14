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
        NavigationStack{
            VStack(spacing: 24){
                Text("おかえりなさい")
                    .font(.largeTitle)
                    .bold()
                TextField("メールアドレス", text: $loginModel.email)
                    .autocorrectionDisabled(true)
                    .textContentType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .background(Color(.secondarySystemBackground))
                    .padding()
                    .cornerRadius(8)
                SecureField("パスワード", text: $loginModel.password)
                    .padding()
                    .textInputAutocapitalization(.never)
                    .background(Color(.secondarySystemBackground))
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
                        Text("ログイン")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .cornerRadius(8)
                    }
                }
                //                .disabled(loginModel.isLoading)
                NavigationLink("新規登録はこちら。", destination: SignupView())
                    .foregroundColor(.green)
                    .padding(.top, 8)
                    .font(.headline)
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $loginModel.loginSuccess){
                TodoListView()
            }
        }
    }
}
