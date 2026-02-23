//
//  SettingsView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    NavigationLink("Profile", destination: ProfileView())
                    NavigationLink("Your Orders", destination: YourOrderView())
                    NavigationLink("History", destination: HistoryView())
                }
                
                Section("Other") {
                    Text("Notifications")
                    Text("Privacy Policy")
                    Text("Help & Support")
                }
            }
            .navigationTitle("Setting")
        }
    }
}

#Preview {
    SettingsView()
}
