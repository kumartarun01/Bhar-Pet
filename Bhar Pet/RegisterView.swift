//
//  RegisterView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct RegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                // MARK: - Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.95, green: 0.90, blue: 0.92),
                        Color(red: 0.98, green: 0.93, blue: 0.88),
                        Color(red: 0.96, green: 0.88, blue: 0.90)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Spacer()
                    
                    // MARK: - Title
                    Text("Register yourself")
                        .font(.custom("Snell Roundhand", size: 40))
                        .foregroundColor(.black)
                    
                    Text("FINDURANT")
                        .font(.system(size: 32, weight: .light, design: .serif))
                        .italic()
                        .foregroundColor(.gray)
                    
                    Text("Restaurant which you know well!!!")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // MARK: - Email Field
                    TextField("E-mail", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // MARK: - Password Field
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    // MARK: - Next Button
                    Button(action: {
                        print("Register tapped")
                    }) {
                        Text("Next")
                            .font(.custom("Snell Roundhand", size: 45))
                            .foregroundColor(.pink)
                    }
                    
                    // MARK: - Already User
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Already user")
                            .foregroundColor(.blue)
                            .padding(.top, 5)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    RegisterView()
}
