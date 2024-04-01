//
//  ScheduleAppointment.swift
//  Vollmed
//
//  Created by Nor, Gustavo on 01/04/24.
//

import Foundation

struct ScheduleAppointmentResponse: Codable, Identifiable {
    let id: Int
    let specialist: Int
    let patient: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case specialist = "idMedico"
        case patient = "idPaciente"
        case date = "data"
    }
}

struct ScheduleAppointmentRequest: Codable {
    let specialist: Int
    let patient: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case specialist = "idMedico"
        case patient = "idPaciente"
        case date = "data"
    }
}
