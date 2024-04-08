//
//  HomeView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct HomeView: View {
    
    let service = WebService()
    var authManager = AuthenticationManager.shared
    
    @State private var specialists: [Specialist] = []
    @State private var isLoading = true
    
    func getSpecialists() async {
        do {
            if let specialist = try await service.getAllSpecialists() {
                self.specialists = specialist
                self.isLoading = false
            }
        } catch {
            print("Ocorreu um erro ao obter os especialista: \(error)")
            self.isLoading = false
        }
    }
    
    func logout() {
        authManager.removeToken()
        authManager.removePatientID()
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(.lightBlue))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.accentColor)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)
                
                if isLoading {
                    ProgressView()
                } else {
                    ForEach(specialists) { specialist in
                        SpecialistCardView(specialist: specialist)
                            .padding(.bottom, 8)
                    }
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear {
            Task {
                await getSpecialists()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    logout()
                } label: {
                    HStack(spacing: 2){
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Logout")
                    }
                }

            }
        }
    }
}

#Preview {
    HomeView()
}
