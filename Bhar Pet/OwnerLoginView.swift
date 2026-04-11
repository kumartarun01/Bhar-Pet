

import SwiftUI
import FirebaseAuth

struct OwnerLoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var isLoggedIn = false
    
    // Callback to go back to AdminUserView
    var onLogout: () -> Void = {}
    
    var body: some View {
        
        if isLoggedIn {
            RootTabView(onLogout: {
                // Firebase logout + go back
                try? Auth.auth().signOut()
                isLoggedIn = false
                onLogout()
            })
        } else {
            
            NavigationView {
                VStack(spacing: 20) {
                    
                    Text("Owner Login 👑")
                        .font(.largeTitle)
                        .bold()
                    
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: login) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
    
    // 🔥 Firebase Login
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                if let error = error {
                    errorMessage = error.localizedDescription
                } else {
                    isLoggedIn = true
                }
            }
        }
    }
}
