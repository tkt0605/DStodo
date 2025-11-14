//
//  SignupView.swift
//  ios
//
//  Created by 駒田隆人 on 2025/11/13.
//

//import Foundation
import SwiftUI

struct SignupView: View {
    @StateObject private var viewModel = SignupViewModel()
    var body: some View {
        NavigationStack{
            VStack(spacing: 24){
                Text("新規登録")
                    .font(.largeTitle)
                    .bold()
                TextField("メールアドレス", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                SecureField("パスワード", text: $viewModel.password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                TextField("ユーザー名", text: $viewModel.nickname)
                    .padding()
                    .textInputAutocapitalization(.never)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(8)
                if let error = viewModel.errorMessage{
                    Text(error)
                        .foregroundStyle(.red)
                }
                
                Button(action: {
                    Task{await viewModel.signup()}
                }){
                    if viewModel.isLoading{
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
    //            .disabled(viewModel.isLoading)
                NavigationLink("ログインはこちら。", destination: LoginView())
                    .foregroundColor(.black)
                    .padding(.top, 8)
                    .font(.headline)
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.signupSuccess){
                TodoListView()
            }
        }
    }
}
