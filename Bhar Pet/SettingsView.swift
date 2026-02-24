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
//                    NavigationLink("Your Orders", destination: YourOrderView2())
//                    NavigationLink("History", destination: HistoryView())
                }
                
                Section("Other") {
                    NavigationLink("Notifications", destination: NotificationView())
                    NavigationLink("Privacy Policy", destination: PrivacyView())
                    NavigationLink("Help & Support", destination: HelpView())
                    NavigationLink("About Us", destination: AboutView())
                    NavigationLink("Follow Us", destination: FollowUsView())
                    NavigationLink("Write a Review", destination: reviewpage())
                }
            }
            .navigationTitle("Setting")
        }.toolbar(.hidden)
    }
}

#Preview {
    SettingsView()
}
