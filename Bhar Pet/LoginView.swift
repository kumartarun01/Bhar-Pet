//
//  LoginView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
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
                
                // MARK: - Login Title
                Text("Login")
                    .font(.custom("Snell Roundhand", size: 40))
                    .foregroundColor(.black)
                
                // MARK: - App Name
                Text("FINDURANT")
                    .font(.system(size: 35, weight: .light, design: .serif))
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
                
                // MARK: - New User & Forget Password
                HStack {
                    Button("New User") {
                        print("New User tapped")
                    }
                    .foregroundColor(.blue)
                    
                    Spacer()
                    
                    Button("Forget Password") {
                        print("Forget Password tapped")
                    }
                    .foregroundColor(.red)
                }
                .padding(.horizontal, 30)
                
                Spacer()
                
                // MARK: - Next Button
                Button(action: {
                    print("Next tapped")
                }) {
                    Text("Next")
                        .font(.custom("Snell Roundhand", size: 45))
                        .foregroundColor(.pink)
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
}
