

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        NavigationStack {
            List {
                Section("Account") {
                    NavigationLink(destination: ProfileView()) {
                        Label("Profile", systemImage: "person.circle.fill")
                    }
                }
                
                Section("Preferences") {
                    NavigationLink(destination: NotificationView()) {
                        Label("Notifications", systemImage: "bell.fill")
                    }
                    NavigationLink(destination: PrivacyView()) {
                        Label("Privacy & Policy", systemImage: "lock.shield.fill")
                    }
                }
                
                Section("More") {
                    NavigationLink(destination: HelpView()) {
                        Label("Help & Support", systemImage: "questionmark.circle.fill")
                    }
                    NavigationLink(destination: AboutView()) {
                        Label("About Us", systemImage: "info.circle.fill")
                    }
                    NavigationLink(destination: FollowUsView()) {
                        Label("Follow Us", systemImage: "heart.fill")
                    }
                    NavigationLink(destination: reviewpage()) {
                        Label("Write a Review", systemImage: "star.fill")
                    }
                }
            }
            .navigationTitle("Settings")
            .listStyle(.insetGrouped)
        }
        .toolbar(.hidden)
    }
}

#Preview {
    SettingsView()
}
