//
//  Specialist.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import Foundation

struct Specialist: Identifiable, Codable {
    let id: Int
    let name: String
    let crm: String
    let imageUrl: String
    let specialty: String
    let email: String
    //let phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "nome"
        case email
        case crm
        case imageUrl = "imageURL"
        case specialty = "especialidade"
        
        //case phoneNumber = "telefone"
    }
}

let specialists: [Specialist] = [
 //   Specialist(id: 5, name: "Dr. Carlos Alberto", crm: "123456", specialty: "Neurologia", email: "carlos.alberto@example.com"),
//    Specialist(id: "l349493", name: "Dra. Maria Aparecida", crm: "789101", imageUrl: "https://images.unsplash.com/photo-1651008376811-b90baee60c1f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80", specialty: "Cardiologia", email: "maria.aparecida@example.com", phoneNumber: "(21) 88888-8888"),
//    Specialist(id: "4435h553", name: "Dr. João Ribeiro", crm: "123987", imageUrl: "https://images.unsplash.com/photo-1622253694242-abeb37a33e97?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=765&q=80", specialty: "Oftalmologia", email: "joao.ribeiro@example.com", phoneNumber: "(11) 77777-7777"),
]
