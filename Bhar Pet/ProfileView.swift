

//
//  ProfileView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
//import PhotosUI

struct ProfileView: View {
    @EnvironmentObject var auth: AuthViewModel
//    @StateObject var auth = AuthViewModel()
    
    @State private var profileImage: UIImage?
    @State private var profileImageURL = ""
    
    @State private var name = ""
    @State private var email = ""
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                
//                Spacer()
                
                Text("Profile")
                    .font(.system(size: 35, weight: .light, design: .serif))
                    .italic()
                
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                }
                
                Text("Restaurant which you know well!!!")
                    .foregroundColor(.gray)
                
                // 🔥 Firebase Name Show
                Text(name.isEmpty ? "" : name)
                    .font(.title2)
                
                // Optional Email Show
                Text(email)
                    .foregroundColor(.gray)
                
                NavigationLink(destination: EditProfileView()) {
                    Text("Edit Profile")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(20)
                }
                
                NavigationLink(destination: HistoryView()) {
                    Text("History")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(20)
                }
                
                NavigationLink(destination: YourOrderView()) {
                    Text("Orders")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(20)
                }
                
                Spacer()
                
                Button {
                    auth.logout()
                } label: {
                    Text("Log Out")
                        .foregroundStyle(.white)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.7))
                        .cornerRadius(20)
                }
                
                Spacer()
            }
            .padding()
        }
        .onAppear {
            loadProfileData()
            loadLocalImage()
        }
    }
}

extension ProfileView {
    
    func loadLocalImage() {
        
        if let base64String = UserDefaults.standard.string(forKey: "profileImage"),
           let imageData = Data(base64Encoded: base64String),
           let image = UIImage(data: imageData) {
            
            self.profileImage = image
        }
    }
    
    func loadProfileData() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference()
        
        ref.child("Findurant").child(uid)
            .observe(.value) { snapshot in
                
                if let data = snapshot.value as? [String: Any] {
                    
                    name = data["name"] as? String ?? ""
                    email = data["email"] as? String ?? ""
                }
            }
    }
}

#Preview {
    ProfileView()
}
