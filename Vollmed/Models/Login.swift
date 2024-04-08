//
//  Login.swift
//  Vollmed
//
//  Created by Nor, Gustavo on 07/04/24.
//

import Foundation

struct LoginRequest: Codable {
    let login: String
    let password: String
        
    enum CodingKeys: String, CodingKey {
        case login
        case password = "senha"
    }
}

struct LoginResponse: Identifiable, Codable {
    let id: String
    let token: String
}
