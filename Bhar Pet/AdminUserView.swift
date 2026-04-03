//
//  AdminUserView.swift
//  Bhar Pet
//
//  Created by iMac1 on 03/04/26.
//

import SwiftUI

struct AdminUserView: View {
    
    enum Role {
        case none, user, admin
    }
    
    @State private var selectedRole: Role = .none
    
    var body: some View {
        ZStack {
            
            // MARK: - TITLE
//            Text("Welcome")
//                .font(.largeTitle)
//                .bold()
//                .padding(.top, 40)
//            
//            Spacer()
            LinearGradient(gradient: Gradient(colors: [
             Color(red: 0.95, green: 0.90, blue: 0.92),
             Color(red: 0.98, green: 0.93, blue: 0.88),
             Color(red: 0.96, green: 0.88, blue: 0.90)
         ]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - ROLE SELECTION
            if selectedRole == .none {
                
                VStack(spacing: 20) {
                    Image("Findurantlogo")
                     .resizable()
                   .frame(width: 300, height: 280)
                     .clipShape(Circle())
                    Button(action: {
                        selectedRole = .user
                    }) {
                        Text("User")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        selectedRole = .admin
                    }) {
                        Text("Owner")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            
            // MARK: - USER VIEW
            else if selectedRole == .user {
                
//                VStack(spacing: 20) {
//                    
                MainTabView()
                    .environmentObject(AuthViewModel())
                    .environmentObject(CartManager())
//
////                    Text("👤 User Page")
////                        .font(.title)
////                        .bold()
////                    
////                    Text("Yeh user ka section hai")
////                        .foregroundColor(.gray)
////                    
////                    Button("⬅ Back") {
////                        selectedRole = .none
////                    }
//                    .padding()
//                }
            }
            
            // MARK: - ADMIN VIEW
            else if selectedRole == .admin {
                
                OwnerLoginView()
//                VStack(spacing: 20) {
//                    
//                    Text("🔐 Admin Page")
//                        .font(.title)
//                        .bold()
//                    
//                    Text("Yeh admin ka section hai")
//                        .foregroundColor(.gray)
//                    
//                    Button("⬅ Back") {
//                        selectedRole = .none
//                    }
//                    .padding()
//                }
            }
            
//            Spacer()
        }
        .animation(.easeInOut, value: selectedRole)
    }
}

#Preview {
    AdminUserView()
}
