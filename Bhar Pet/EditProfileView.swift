//
//  EditProfileView.swift
//  Bhar Pet
//
//  Created by iMac1 on 25/02/26.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import PhotosUI

struct EditProfileView: View {
    
    @State private var name = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var location = ""
    @State private var bio = ""
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var profileImage: UIImage?
    @State private var profileImageURL: String = ""
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 20) {
                
                Text("Edit Profile")
                    .font(.title.bold())
                
                // MARK: Profile Image Picker
                ZStack(alignment: .bottomTrailing) {
                    
                    if let image = profileImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.green)
                    }
                    
                    PhotosPicker(selection: $selectedItem, matching: .images) {
                        Image(systemName: "camera.fill")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black)
                            .clipShape(Circle())
                    }
                }
                .onChange(of: selectedItem) {
                    loadImage(from: selectedItem)
                }
                EditProfileTextField(title: "Full Name", text: $name)
                EditProfileTextField(title: "Email", text: $email)
                EditProfileTextField(title: "Phone", text: $phone)
                EditProfileTextField(title: "Location", text: $location)
                
                VStack(alignment: .leading) {
                    Text("Bio").font(.headline)
                    TextEditor(text: $bio)
                        .frame(height: 100)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                }
                
                Button("Save Changes") {
                    updateProfile()
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(12)
            }
            .padding()
        }
        .onAppear {
            loadUserData()
        }
    }
}

struct EditProfileTextField: View {
    
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            
            Text(title)
                .font(.headline)
            
            TextField("Enter \(title)", text: $text)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
    }
}

extension EditProfileView {
    
    func loadImage(from item: PhotosPickerItem?) {
        guard let item = item else { return }
        
        item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                if case .success(let data) = result,
                   let data = data,
                   let uiImage = UIImage(data: data) {
                    self.profileImage = uiImage
                }
            }
        }
    }
    
    func updateProfile() {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference()
        
        // 🔹 Save details to Firebase
        let updatedData: [String: Any] = [
            "name": name,
            "email": email,
            "mobile": phone,
            "location": location,
            "bio": bio
        ]
        
        ref.child("Findurant").child(uid)
            .updateChildValues(updatedData) { error, _ in
                
                if let error = error {
                    print("DB Error:", error.localizedDescription)
                } else {
                    print("Details Saved Successfully")
                }
            }
        
        // 🔹 Save image locally (no firebase)
        if let image = profileImage,
           let imageData = image.jpegData(compressionQuality: 0.5) {
            
            let base64String = imageData.base64EncodedString()
            UserDefaults.standard.set(base64String, forKey: "profileImage")
            
            print("Image Saved Locally")
        }
    }
    
    func saveUserData(uid: String, imageURL: String) {
        let ref = Database.database().reference()
        
        let updatedData: [String: Any] = [
            "name": name,
            "email": email,
            "mobile": phone,
            "location": location,
            "bio": bio,
            "profileImageURL": imageURL
        ]
        
        ref.child("Findurant").child(uid)
            .updateChildValues(updatedData)
    }
    
    func loadUserData() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let ref = Database.database().reference()
        
        ref.child("Findurant").child(uid)
            .observeSingleEvent(of: .value) { snapshot in
                
                if let data = snapshot.value as? [String: Any] {
                    
                    name = data["name"] as? String ?? ""
                    email = data["email"] as? String ?? ""
                    phone = data["mobile"] as? String ?? ""
                    location = data["location"] as? String ?? ""
                    bio = data["bio"] as? String ?? ""
                    profileImageURL = data["profileImageURL"] as? String ?? ""
                    
                    if let url = URL(string: profileImageURL) {
                        DispatchQueue.global().async {
                            if let data = try? Data(contentsOf: url),
                               let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.profileImage = image
                                }
                            }
                        }
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
    }
}
