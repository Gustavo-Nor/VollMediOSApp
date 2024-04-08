//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import Foundation
import UIKit

struct WebService {
    
    private let baseURL = "http://localhost:8080"
    let imageCache = NSCache<NSString, UIImage>()
    
    var authManager = AuthenticationManager.shared
    
//    func logoutPatient() async throws -> Bool {
//        let endpoint = baseURL + "/logout"
//    }
    
    func loginPatient(login: String, password: String) async throws -> LoginResponse? {
        let endpoint = baseURL + "/login"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let loginRequest = LoginRequest(login: login, password: password)
        
        let jsonData = try JSONEncoder().encode(loginRequest)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        
        return loginResponse
    }
    
    func registerPatient(patient: Patient) async throws -> Patient? {
        let endpoint = baseURL + "/pacientes/public"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let jsonData = try JSONEncoder().encode(patient)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let patient = try JSONDecoder().decode(Patient.self, from: data)
        
        print(patient)
        
        return patient
    }
    
    func cancelAppointment(appointmentID: Int, reasonToCancel: String) async throws -> Bool {
        let endpoint = baseURL + "/consultas/" + "\(appointmentID)"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return false
        }
        
        guard let token = authManager.token else {
            print("Token não informado!")
            return false
        }
        
        let requestData: [String: String] = ["motivoCancelamento": reasonToCancel]
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (_ , response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 {
            return true
        }
        
        return false
    }
    
    func rescheduleAppointment (appointmentID: Int, date: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint = baseURL + "/consultas/" + "\(appointmentID)"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        guard let token = authManager.token else {
            print("Token não informado!")
            return nil
        }
        
        let requestData: [String: String] = ["data": date]
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        
        return appointmentResponse
    }
    
    func getAllAppointmentsFromPatient(patientID: String) async throws -> [Appointment]? {
        let endpoint = baseURL + "/consultas/paciente/" + "\(patientID)"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        guard let token = authManager.token else {
            print("Token não informado!")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let appointments = try JSONDecoder().decode([Appointment].self, from: data)
        
        return appointments
    }
    
    func scheduleAppointment(specialistID: Int,
                             patientID: String,
                             date: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint = baseURL + "/consultas"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        guard let token = authManager.token else {
            print("Token não informado!")
            return nil
        }
        
        let appointment = ScheduleAppointmentRequest(specialist: specialistID, patient: patientID, date: date)
        
        let jsonData = try JSONEncoder().encode(appointment)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        
        return appointmentResponse
    }
    
    func downloadImage(from imageURL: String) async throws -> UIImage? {
        guard let url = URL(string: imageURL) else {
            print("Erro na URL!")
            return nil
        }
        
        // Verificar cache
        if let cachedImage = imageCache.object(forKey: imageURL as NSString) {
            return cachedImage
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
                return nil
            }

            // Salvar imagem no cache
            imageCache.setObject(image, forKey: imageURL as NSString)
        
        return UIImage(data: data)
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let endpoint = baseURL + "/medicos/public"
        
        guard let url = URL(string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        
        //print("debug \(specialists)")
        
        return specialists
    }
    
    
}

