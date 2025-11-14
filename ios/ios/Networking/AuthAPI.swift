//
//  AuthAPI.swift
//  ios
//
//  Created by 駒田隆人 on 2025/10/26.
//

import Foundation

struct AuthAPI {
    static let baseURL = "http://localhost:8000/api"
    static func loginAsync(email: String, password: String, completion: @escaping (Result<AuthToken, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/token/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let loginRequest = LoginRequest(email: email, password: password)
        guard let httpBody = try? JSONEncoder().encode(loginRequest) else { return }
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }

            do {
                let token = try JSONDecoder().decode(AuthToken.self, from: data)
                completion(.success(token))
            } catch let decodeError {
                completion(.failure(decodeError))
            }
        }.resume()
    }
    static func signup(email: String, password: String,nickname: String , completion: @escaping(Result<AuthToken, Error>) -> Void){
        guard let url = URL(string: "\(baseURL)/register/") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let signupRequest = SignupRequest(email: email, password: password, nickname: nickname)
        guard let httpBody = try? JSONEncoder().encode(signupRequest) else {return}
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do{
                let token = try JSONDecoder().decode(AuthToken.self, from: data)
                completion(.success(token))
            }catch let decodeError{
                completion(.failure(decodeError))
            }
        }.resume()
    }
//    static func CreateTodoItem(
//        id: UUID, 
//        title: String, 
//        nemo: String, 
//        is_completed: Bool, 
//        created_at: String, 
//        updated_at: String,
//
//        completion: @escaping(Result<TodoItem, Error>) -> Void
//    ){
//        guard let url = URL(string: "\(baseURL)/todo/create/") else { return }
//        var request = URLRequest(url: url)
//
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let todoItem = TodoItem(
//            id: id,
//            title: title, 
//            nemo: nemo, 
//            is_completed: is_completed,
//            created_at: created_at,
//            updated_at: updated_at
//        )
//        guard let httpBody = try? JSONEncoder().encode(todoItem) else { return }
//        request.httpBody = httpBody
//        URLSession.shared.dataTask(with: request){data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let data  = data else {
//                completion(.failure(URLError(.badServerResponse)))
//                return
//            }
//            do {
//                let todoitem = JSONDecoder().decode(TodoItem.self, from: data)
//                completion(.success(todoitem))
//            } catch let error{
//                completion(.failure(error))
//            }
//        }.resume()
//    }
}
