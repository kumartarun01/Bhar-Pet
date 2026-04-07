

import SwiftUI
import FirebaseAuth

struct AdminUserView: View {
    
    enum Role {
        case none, user, admin
    }
    
    @StateObject private var userAuth = AuthViewModel()
    @StateObject private var userCart = CartManager()
    @State private var selectedRole: Role = .none
    
    var body: some View {
        ZStack {
            
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
                
                MainTabView()
                    .environmentObject(userAuth)
                    .environmentObject(userCart)
                    .onChange(of: userAuth.isAuthenticated) { isAuth in
                        // Jab logout hoga (isAuthenticated false hoga), role reset karo
                        if !isAuth {
                            selectedRole = .none
                        }
                    }
            }
            
            // MARK: - ADMIN VIEW
//            else if selectedRole == .admin {
//                
//                OwnerLoginView()
//            }
            else if selectedRole == .admin {
                
                OwnerLoginView()
                    .onChange(of: Auth.auth().currentUser) { _ in
                        if Auth.auth().currentUser == nil {
                            selectedRole = .none
                        }
                    }
            }
        }
        .animation(.easeInOut, value: selectedRole)
    }
}

#Preview {
    AdminUserView()
}
