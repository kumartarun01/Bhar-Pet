//
//  OwnerLoginView.swift
//  Bhar Pet
//
//  Created by iMac1 on 03/04/26.
//

import SwiftUI

struct OwnerLoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var message = ""
    @State private var isLoggedIn = false
    
    // Hardcoded Owner Credentials
    let ownerUsername = "owner"
    let ownerPassword = "1234"
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Owner Login")
                .font(.largeTitle)
                .bold()
            
            // Username Field
            TextField("Enter Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            // Password Field
            SecureField("Enter Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
            
            // Submit Button
            Button(action: {
                if username == ownerUsername && password == ownerPassword {
                    message = "Login Successful ✅"
                    isLoggedIn = true
                } else {
                    message = "Invalid Username or Password ❌"
                }
            }) {
                Text("Submit")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            
            // Message
            Text(message)
                .foregroundColor(.red)
            
            // After Login Success
            if isLoggedIn {
                Text("🎉 Welcome Owner!")
                    .font(.title2)
                    .foregroundColor(.green)
            }
            
        }
        .padding()
    }
}

#Preview {
    OwnerLoginView()
}
