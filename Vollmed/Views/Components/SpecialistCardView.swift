//
//  SpecialistCardView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct SpecialistCardView: View {
    
    var specialist: Specialist
    var appointment: Appointment?
    
    let service = WebService()
    
    @State private var specialistImage: UIImage?
    
    func downloadImage() async {
        do {
            if let image = try await service.downloadImage(from: specialist.imageUrl) {
                self.specialistImage = image
            }
        } catch {
            print("Ocorreu um erro ao obter a imagem: \(error)")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16.0) {
                
                if let specialistImage {
                    Image(uiImage: specialistImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                } else {
                    Image(.doctor)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(specialist.name)
                        .font(.title3)
                        .bold()
                    Text(specialist.specialty.lowercased().capitalized)
                    if let appointment {
                        Text(appointment.date.convertDateStringToReadableDate())
                            .bold()
                    }
                }
            }
            
            if let appointment {
                HStack {
                    NavigationLink {
                        ScheduleAppointmentView(specialistID: specialist.id, isRescheduleView: true, appointmentID: appointment.id)
                    } label: {
                        ButtonView(text: "Remarcar")
                    }
                    
                    NavigationLink {
                        CancelAppointmentView(appointmentID: appointment.id)
                    } label: {
                        ButtonView(text: "Cancelar", buttonType: .cancel)
                    }
                    
    
                }
            } else {
                NavigationLink {
                    ScheduleAppointmentView(specialistID: specialist.id)
                } label: {
                    ButtonView(text: "Agendar consulta")
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.lightBlue).opacity(0.15))
        .cornerRadius(16.0)
        .onAppear() {
            Task {
                await downloadImage()
            }
        }
    }
}

#Preview {
    SpecialistCardView(specialist:
        Specialist(id: 5,
                   name: "Dr. Carlos Alberto",
                   crm: "123456",
                   imageUrl: "https://images.unsplash.com/photo-1651008376811-b90baee60c1f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80",
                   specialty: "Neurologia",
                   email: "carlos.alberto@example.com"
                  ))
}
