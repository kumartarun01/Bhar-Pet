//
//  ResetPasswordView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    
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
                    Text("Re-set Password")
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
                    
                    // MARK: - Email
                    TextField("E-mail", text: $email)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // MARK: - New Password
                    SecureField("New Password", text: $newPassword)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    // MARK: - Confirm Password
                    SecureField("confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    // MARK: - Done Button
                    Button(action: {
                        print("Password Reset Done")
                    }) {
                        Text("Done")
                            .font(.custom("Snell Roundhand", size: 45))
                            .foregroundColor(.pink)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Back")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ResetPasswordView()
}
