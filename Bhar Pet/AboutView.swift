

import SwiftUI

struct AboutView: View {
    
    let teamMembers = [
        (name: "Arjun Sharma", role: "Co-Founder & CEO", icon: "person.fill"),
        (name: "Priya Mehta", role: "Head of Design", icon: "paintbrush.fill"),
        (name: "Rahul Verma", role: "Lead Developer", icon: "chevron.left.forwardslash.chevron.right"),
        (name: "Sneha Iyer", role: "Operations Lead", icon: "chart.bar.fill")
    ]
    
    let milestones = [
        (year: "2023", text: "Bhar Pet founded in Goa"),
        (year: "2024", text: "500+ restaurants onboarded"),
        (year: "2025", text: "1 lakh+ happy customers"),
        (year: "2026", text: "Expanding across India 🚀")
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    // Header
                    Text("About Us")
                        .font(.custom("Snell Roundhand", size: 36))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 16)
                    
                    // Logo + Tagline
                    VStack(spacing: 10) {
                        Image("bhar_pet_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                        
                        Text("Bhar Pet")
                            .font(.title)
                            .bold()
                        
                        Text("Your hunger, our mission 🍽️")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 20)
                    
                    // Mission Card
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Our Mission", systemImage: "heart.fill")
                            .font(.headline)
                            .foregroundColor(.red)
                        
                        Text("Bhar Pet is your ultimate dining companion, designed to make finding the perfect restaurant effortless. Whether you're craving local favorites or exploring new culinary experiences, we help you discover the best places to eat.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    
                    // Our Journey (Timeline)
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Our Journey")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                        
                        VStack(spacing: 0) {
                            ForEach(Array(milestones.enumerated()), id: \.offset) { idx, milestone in
                                HStack(alignment: .top, spacing: 14) {
                                    VStack(spacing: 0) {
                                        Circle()
                                            .fill(Color.red)
                                            .frame(width: 12, height: 12)
                                        if idx < milestones.count - 1 {
                                            Rectangle()
                                                .fill(Color.red.opacity(0.3))
                                                .frame(width: 2, height: 36)
                                        }
                                    }
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(milestone.year)
                                            .font(.caption)
                                            .bold()
                                            .foregroundColor(.red)
                                        Text(milestone.text)
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal)
                                .padding(.bottom, idx < milestones.count - 1 ? 0 : 12)
                            }
                        }
                        .padding(.top, 4)
                        .padding(.bottom, 12)
                        .background(Color.white)
                        .cornerRadius(14)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 16)
                    
                    // Stats Row
                    HStack(spacing: 12) {
                        AboutStatCard(value: "500+", label: "Restaurants")
                        AboutStatCard(value: "1L+", label: "Customers")
                        AboutStatCard(value: "4.8★", label: "App Rating")
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    
                    // Team
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Meet the Team")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        VStack(spacing: 0) {
                            ForEach(Array(teamMembers.enumerated()), id: \.offset) { idx, member in
                                HStack(spacing: 14) {
                                    Image(systemName: member.icon)
                                        .foregroundColor(.white)
                                        .frame(width: 36, height: 36)
                                        .background(Color.red.opacity(0.8))
                                        .clipShape(Circle())
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(member.name)
                                            .font(.subheadline)
                                            .bold()
                                        Text(member.role)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                    Spacer()
                                }
                                .padding()
                                if idx < teamMembers.count - 1 {
                                    Divider().padding(.leading, 66)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(14)
                        .padding(.horizontal)
                    }
                    .padding(.bottom, 16)
                    
                    // Version Info
                    VStack(spacing: 4) {
                        Text("Bhar Pet v2.0.0")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("Made with ❤️ in Goa, India")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AboutStatCard: View {
    let value: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .bold()
                .foregroundColor(.red)
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        AboutView()
    }
}
