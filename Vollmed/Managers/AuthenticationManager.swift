//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Nor, Gustavo on 07/04/24.
//

import Foundation

class AuthenticationManager: ObservableObject { 
    
    static let shared = AuthenticationManager()
    
    @Published var token: String?
    @Published var patientID: String?
    
    private init() {
        self.token = KeychainHelper.get(for: "token")
        self.patientID = KeychainHelper.get(for: "patient-id")
    }
    
    func saveToken(token: String) {
        KeychainHelper.save(value: token, key: "token")
        self.token = token
    }
    
    func removeToken() {
        KeychainHelper.remove(for: "token")
        self.token = nil
    }
    
    func savePatientID(id: String) {
        KeychainHelper.save(value: id, key: "patient-id")
        self.patientID = id
    }
    
    func removePatientID() {
        KeychainHelper.remove(for: "patient-id")
        self.patientID = nil
    }
}
