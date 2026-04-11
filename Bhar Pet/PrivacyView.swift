import SwiftUI

struct PrivacyView: View {
    
    @State private var locationAccess = true
    @State private var dataSharing = false
    @State private var personalizedAds = false
    @State private var analyticsTracking = true
    
    let sections: [(title: String, icon: String, color: Color, body: String)] = [
        (
            "Data We Collect",
            "tray.fill",
            .blue,
            "We collect your name, email, phone number, and location only to provide you the best food ordering experience. Your data is never sold to third parties."
        ),
        (
            "How We Use Your Data",
            "lock.shield.fill",
            .green,
            "Your data is used solely to process orders, personalize recommendations, and improve our services. We use industry-standard encryption to keep your information safe."
        ),
        (
            "Your Rights",
            "person.badge.shield.checkmark",
            .orange,
            "You have the right to access, update, or delete your personal data at any time. Contact us at privacy@bharpet.com for any requests."
        ),
        (
            "Cookies & Tracking",
            "eye.slash.fill",
            .purple,
            "We use cookies to enhance your experience. You can control cookie settings below or through your device settings."
        )
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    // Header
                    Text("Privacy & Policy")
                        .font(.custom("Snell Roundhand", size: 34))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 16)
                    
                    // Policy Sections
                    VStack(spacing: 12) {
                        ForEach(sections, id: \.title) { section in
                            PrivacySectionCard(
                                title: section.title,
                                icon: section.icon,
                                color: section.color,
                                bodyText: section.body
                            )
                        }
                    }
                    .padding(.horizontal)
                    
                    // Privacy Controls
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Privacy Controls")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 20)
                            .padding(.bottom, 8)
                        
                        VStack(spacing: 0) {
                            PrivacyToggleRow(
                                title: "Location Access",
                                subtitle: "For restaurant discovery near you",
                                icon: "location.fill",
                                color: .blue,
                                isOn: $locationAccess
                            )
                            Divider().padding(.leading, 56)
                            PrivacyToggleRow(
                                title: "Data Sharing",
                                subtitle: "Share anonymized data to improve service",
                                icon: "arrow.triangle.2.circlepath",
                                color: .green,
                                isOn: $dataSharing
                            )
                            Divider().padding(.leading, 56)
                            PrivacyToggleRow(
                                title: "Personalized Ads",
                                subtitle: "See ads relevant to your interests",
                                icon: "megaphone.fill",
                                color: .orange,
                                isOn: $personalizedAds
                            )
                            Divider().padding(.leading, 56)
                            PrivacyToggleRow(
                                title: "Analytics Tracking",
                                subtitle: "Help us improve the app experience",
                                icon: "chart.bar.fill",
                                color: .purple,
                                isOn: $analyticsTracking
                            )
                        }
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    // Footer
                    Text("Last updated: April 2026")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.top, 20)
                        .padding(.bottom, 30)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PrivacySectionCard: View {
    let title: String
    let icon: String
    let color: Color
    let bodyText: String
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: { withAnimation { isExpanded.toggle() } }) {
                HStack {
                    Image(systemName: icon)
                        .foregroundColor(color)
                        .frame(width: 28)
                    Text(title)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            if isExpanded {
                Text(bodyText)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.bottom, 12)
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

struct PrivacyToggleRow: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 28)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline)
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Spacer()
            Toggle("", isOn: $isOn)
                .tint(.green)
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        PrivacyView()
    }
}
