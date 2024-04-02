//
//  Appointment.swift
//  Vollmed
//
//  Created by Nor, Gustavo on 02/04/24.
//

import Foundation

struct Appointment: Identifiable, Codable {
    let id: Int
    let date: String
    let specialist: Specialist
    
    enum CodingKeys: String, CodingKey{
        case id
        case date = "data"
        case specialist = "medico"
    }
}
