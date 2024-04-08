//
//  MyAppointmentsView.swift
//  Vollmed
//
//  Created by Nor, Gustavo on 01/04/24.
//

import SwiftUI

struct MyAppointmentsView: View {
    
    let service = WebService()
    var authManager = AuthenticationManager.shared
    
    @State private var appointments: [Appointment] = []
    
    func getAllAppointments() async {
        guard let patientID = authManager.patientID else {
            return
        }
        
        do {
            if let appointments = try await service.getAllAppointmentsFromPatient(patientID: patientID) {
                self.appointments = appointments
            }
        } catch {
            print("Ocorreu um erro ao obter consultas: \(error)")
        }
        
    }
    
    var body: some View {
        VStack {
            if appointments.isEmpty {
                    Text("Não há nenhuma consulta agendada no momento!")
                    .font(.title2)
                        .padding()
                        .foregroundStyle(Color(.cancel))
                        .multilineTextAlignment(.center)
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(appointments) { appoinntment in
                            SpecialistCardView(specialist: appoinntment.specialist, appointment: appoinntment)
                        }
                }
        }
        }
        .navigationTitle("Minhas consultas")
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear() {
            Task {
                await getAllAppointments()
            }
        }
    }
}

#Preview {
    MyAppointmentsView()
}
