

import SwiftUI

struct HelpView: View {
    
    @State private var problemText: String = ""
    @State private var selectedCategory: String = "Order Issue"
    @State private var isSubmitted = false
    @State private var showAlert = false
    
    let categories = ["Order Issue", "Payment Problem", "App Bug", "Restaurant Query", "Other"]
    
    let faqs: [(q: String, a: String)] = [
        ("How do I place an order?", "Go to Home, select a food item, choose quantity and tap 'Add to Cart'. Then proceed to payment from the Cart screen."),
        ("How do I track my order?", "After placing an order, go to Profile → Orders → Tap 'Track Order' to see live location of your delivery."),
        ("Can I cancel my order?", "Orders can be cancelled within 2 minutes of placing. Contact support immediately if you need help."),
        ("How do I get a refund?", "Refunds are processed within 5-7 business days. Report the issue using the form below and we'll handle it."),
        ("How do I change my delivery address?", "You can update your address in Profile → Edit Profile before placing a new order.")
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    
                    // Header
                    Text("Help & Support")
                        .font(.custom("Snell Roundhand", size: 34))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 16)
                    
                    // Quick Contact Buttons
                    HStack(spacing: 12) {
                        HelpContactButton(icon: "phone.fill", label: "Call Us", color: .green) {
                            if let url = URL(string: "tel://+911234567890") {
                                UIApplication.shared.open(url)
                            }
                        }
                        HelpContactButton(icon: "envelope.fill", label: "Email Us", color: .blue) {
                            if let url = URL(string: "mailto:support@bharpet.com") {
                                UIApplication.shared.open(url)
                            }
                        }
                        HelpContactButton(icon: "bubble.left.fill", label: "Live Chat", color: .orange) {
                            // Chat action (future integration)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 16)
                    
                    // FAQ Section
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Frequently Asked Questions")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.bottom, 8)
                        
                        VStack(spacing: 8) {
                            ForEach(faqs, id: \.q) { faq in
                                FAQCard(question: faq.q, answer: faq.a)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Report Problem Form
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Report a Problem")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 20)
                        
                        VStack(spacing: 12) {
                            // Category Picker
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Category")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(categories, id: \.self) { cat in
                                            Text(cat)
                                                .font(.caption)
                                                .padding(.vertical, 6)
                                                .padding(.horizontal, 12)
                                                .background(selectedCategory == cat ? Color.red : Color.gray.opacity(0.15))
                                                .foregroundColor(selectedCategory == cat ? .white : .primary)
                                                .cornerRadius(20)
                                                .onTapGesture { selectedCategory = cat }
                                        }
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            
                            // Text Area
                            VStack(alignment: .leading, spacing: 6) {
                                Text("Describe your problem")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                
                                ZStack(alignment: .topLeading) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                                        .background(Color.white.cornerRadius(10))
                                    
                                    if problemText.isEmpty {
                                        Text("Tell us what went wrong...")
                                            .foregroundColor(.gray.opacity(0.6))
                                            .padding(12)
                                    }
                                    
                                    TextEditor(text: $problemText)
                                        .padding(8)
                                        .frame(minHeight: 120)
                                        .background(Color.clear)
                                        .scrollContentBackground(.hidden)
                                }
                                .frame(minHeight: 120)
                                .padding(.horizontal)
                            }
                            
                            // Submit Button
                            Button(action: {
                                if !problemText.trimmingCharacters(in: .whitespaces).isEmpty {
                                    showAlert = true
                                }
                            }) {
                                Text("Submit Report")
                                    .bold()
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(problemText.isEmpty ? Color.gray.opacity(0.3) : Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            .disabled(problemText.isEmpty)
                            .padding(.horizontal)
                        }
                        .padding(.vertical, 12)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 30)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Report Submitted ✅", isPresented: $showAlert) {
            Button("OK") {
                problemText = ""
            }
        } message: {
            Text("Thank you! We've received your report for '\(selectedCategory)'. Our team will get back to you within 24 hours.")
        }
    }
}

struct HelpContactButton: View {
    let icon: String
    let label: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(color)
                    .cornerRadius(14)
                Text(label)
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
    }
}

struct FAQCard: View {
    let question: String
    let answer: String
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: { withAnimation(.spring()) { isExpanded.toggle() } }) {
                HStack {
                    Text(question)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            if isExpanded {
                Text(answer)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                    .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.04), radius: 3, x: 0, y: 2)
    }
}

#Preview {
    NavigationStack {
        HelpView()
    }
}
