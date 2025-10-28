//
//  AuthAPI.swift
//  ios
//
//  Created by 駒田隆人 on 2025/10/26.
//

import Foundation

struct AUthAPI {
    static let baseURL = "http://localhost:8000/api"

    static func login(email: String, password: String, completion: @escaping (Result<AuthToken, Error>) -> Void){
        guard let url = URL(String: "\(baseURL)/login/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let LoginRequest = LoginRequest(email:email, password:password)
        guard let httpBody = try? JSONEncoder().encode(LoginRequest) else { return }
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) {data, reqponse, error in 
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let token = try JSONEncoder().decode(AuthToken.self, from: data)
                completion(.seccess(token))
            }catch let decodeError {
                completion(.failure(error))
            }
        }.resume()
    }

    static func signup(email: String, password: String, nickname: String, completion: @escaping(Result<AuthToken, Error> -> Void)){
        guard let url = URL(String: "\(baseURL)/register/") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let SignupRequest = SignupRequest(email: email, password: password, nickname: nickname)
        guard let httpBody = try? JSONEncoder().encode(SignupRequest) else { return }
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) {data, response, error in 
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data  = data else {return}
            do {
                let token = try JSONEncoder().decode(AuthToken.self, from:data)
                completion(.success(token))
            }catch let decodeError {
                completion(.failure(error))
            }
        }.resume()
    }

    static func CreateTodoItem(
        id: UUID, 
        title: String, 
        nemo: String, 
        is_completed: Bool, 
        created_at: String, 
        updated_at: String,

        completion: @escaping(Result<TodoItem, Error> -> Void)
    ){
        guard let url = URL(String: "\(baseURL)/todo/create/") else { return }
        var request = URLRequest(url: url)

        reqponse.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let TodoItem = TodoItem(
            id: id, 
            title: title, 
            nemo: nemo, 
            is_completed: is_completed,
            created_at: created_at,
            updated_at: updated_at
        )
        guard let httpBody = try? JSONEncoder().encode(TodoItem) else { return }
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request){data, reqponse, error in
            do {
                let todoitem = JSONEncoder().decode(TodoItem.self, from: data)
                completion(.success(todoitem))
            } catch error {
                completion(.failure(error))
            }
        }.resume()
    }

}