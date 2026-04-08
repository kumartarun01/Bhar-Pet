import SwiftUI


struct OrderHistoryView2: View {
    @ObservedObject var manager = ReservationManager.shared
        
        var body: some View {
            List {
                ForEach(manager.reservations) { r in
                    
                    VStack(alignment: .leading) {
                        
                        Text(r.restaurantName).bold()
                        Text("👤 \(r.customerName)")
                        Text("📞 \(r.phoneNumber)")
                        Text("🪑 Table: \(r.tableNumber)")
                        Text("👥 Members: \(r.members)")
                        
                        Text("From: \(r.startDate.formatted())")
                        Text("To: \(r.endDate.formatted())")
                        
                        Text("💳 \(r.paymentMethod)")
                            .foregroundColor(.green)
                    }
                }
            }
            .onAppear {
                manager.removeExpiredReservations()
            }
        }
    }

#Preview {
    OrderHistoryView2()
}
