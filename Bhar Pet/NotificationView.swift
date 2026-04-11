


import SwiftUI

struct NotificationView: View {
    
    @State private var orderUpdates = true
    @State private var promotions = false
    @State private var newRestaurants = true
    @State private var reminders = true
    @State private var sound = true
    @State private var vibration = true
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Header
                Text("Notifications")
                    .font(.custom("Snell Roundhand", size: 34))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 16)
                
                List {
                    Section("Order Alerts") {
                        Toggle(isOn: $orderUpdates) {
                            Label {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Order Updates")
                                        .font(.body)
                                    Text("Get notified when your order status changes")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            } icon: {
                                Image(systemName: "bag.fill")
                                    .foregroundColor(.orange)
                            }
                        }
                        .tint(.green)
                        
                        Toggle(isOn: $reminders) {
                            Label {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Order Reminders")
                                        .font(.body)
                                    Text("Remind me to reorder my favorites")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            } icon: {
                                Image(systemName: "clock.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .tint(.green)
                    }
                    
                    Section("Offers & Promotions") {
                        Toggle(isOn: $promotions) {
                            Label {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Deals & Offers")
                                        .font(.body)
                                    Text("Special discounts and limited-time offers")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            } icon: {
                                Image(systemName: "tag.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        .tint(.green)
                        
                        Toggle(isOn: $newRestaurants) {
                            Label {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("New Restaurants")
                                        .font(.body)
                                    Text("Know when new restaurants join Bhar Pet")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            } icon: {
                                Image(systemName: "fork.knife.circle.fill")
                                    .foregroundColor(.purple)
                            }
                        }
                        .tint(.green)
                    }
                    
                    Section("Sound & Vibration") {
                        Toggle(isOn: $sound) {
                            Label {
                                Text("Sound")
                            } icon: {
                                Image(systemName: "speaker.wave.2.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .tint(.green)
                        
                        Toggle(isOn: $vibration) {
                            Label {
                                Text("Vibration")
                            } icon: {
                                Image(systemName: "iphone.radiowaves.left.and.right")
                                    .foregroundColor(.gray)
                            }
                        }
                        .tint(.green)
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NotificationView()
    }
}
