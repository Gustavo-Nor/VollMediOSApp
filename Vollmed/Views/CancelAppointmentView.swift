//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Nor, Gustavo on 02/04/24.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var appointmentID: Int
    let service = WebService()
    
    @State private var reasonToCancel = ""
    @State private var showAlert = false
    @State private var isConsultaCancelada = false
    
    
    func cancelAppointment() async {
        do {
            if try await service.cancelAppointment(appointmentID: appointmentID, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso!")
                isConsultaCancelada = true
            }
        } catch {
            print("Ocorreu um erro ao desmarcar a consulta: \(error)")
            isConsultaCancelada = false
        }
        showAlert = true
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Conte-nos o motivo do cancelamento da sua consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .cornerRadius(16)
                .frame(maxHeight: 300)
            
            Button(action: {
                Task {
                    await cancelAppointment()
                }
            }, label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
            })
        }
        .padding()
        .navigationTitle("Cancelar consulta")
        .navigationBarTitleDisplayMode(.large)
        .alert(isConsultaCancelada ? "Sucesso!" : "Ops, algo deu errado!", isPresented: $showAlert, presenting: isConsultaCancelada) { _ in
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Ok")
            })
        } message: { isCanceled in
            if isCanceled {
                Text("A consulta foi cancelada com sucesso!")
            } else {
                Text("Houve um erro ao cancelar sua consulta. Por favor tente novamente ou entre em contato via telefone.")
            }
        }
    }
}

#Preview {
    CancelAppointmentView(appointmentID: 123)
}
