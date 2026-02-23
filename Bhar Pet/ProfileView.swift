import SwiftUI

//
//  ProfileView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

struct ProfileView: View {
    
    var body: some View {
        @StateObject  var auth = AuthViewModel()
        NavigationStack {
            VStack(spacing: 20) {
                
                Spacer()
                
                Text("FINDURANT")
                    .font(.system(size: 35, weight: .light, design: .serif))
                    .italic()
                
                Image(systemName: "person.fill") // Add in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
                
                Text("Restaurant which you know well!!!")
                    .foregroundColor(.gray)
                
                Text("John")
                    .font(.title2)
                
                Spacer()
                
                NavigationLink(destination: HistoryView()) {
                    Text("History")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(20)
                }
                
                NavigationLink(destination: YourOrderView()) {
                    Text("orders")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(20)
                }
                
                Spacer()
                
                NavigationLink{
                    MainTabView()
                }label: {
                    Text("Logout")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.red.opacity(0.3))
                .cornerRadius(20)
                
                Spacer()
            }.padding()
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    ProfileView()
}

