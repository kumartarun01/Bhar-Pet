import SwiftUI
import Combine
import UserNotifications

// MARK: - MODEL
struct Reservation: Identifiable, Codable {
    var id = UUID()
    let restaurantName: String
    let startDate: Date
    let endDate: Date
    let members: Int
    let customerName: String
    let phoneNumber: String
    let tableNumber: Int
    let paymentMethod: String
}

// MARK: - MANAGER
class ReservationManager: ObservableObject {
    
    static let shared = ReservationManager()
    
    @Published var reservations: [Reservation] = []
    
    private init() {
        load()
        removeExpiredReservations()
    }
    
    func add(_ reservation: Reservation) {
        reservations.append(reservation)
        save()
    }
    
    // 🎯 Auto assign table (simple logic)
    func generateTableNumber() -> Int {
        let usedTables = reservations.map { $0.tableNumber }
        for i in 1...20 {
            if !usedTables.contains(i) {
                return i
            }
        }
        return Int.random(in: 21...50)
    }
    
    func removeExpiredReservations() {
        let now = Date()
        reservations.removeAll { $0.endDate < now }
        save()
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(reservations) {
            UserDefaults.standard.set(data, forKey: "reservations")
        }
    }
    
    private func load() {
        if let data = UserDefaults.standard.data(forKey: "reservations"),
           let decoded = try? JSONDecoder().decode([Reservation].self, from: data) {
            reservations = decoded
        }
    }
}

// MARK: - NOTIFICATIONS
class NotificationManager {
    
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }
    
    func schedule(for reservation: Reservation) {
        let content = UNMutableNotificationContent()
        content.title = "🍽️ Reservation Reminder"
        content.body = "Table \(reservation.tableNumber) at \(reservation.restaurantName) is booked!"
        
        let components = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: reservation.startDate
        )
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}

// MARK: - MAIN SCREEN
struct ReservationView: View {
    
    let restaurants = [
        ("restaurant1", "Foraged Fare", "Peaceful Environment, Fresh Food..."),
        ("restaurant2", "Rose Cafe", "Romantic vibes..."),
        ("restaurant3", "Olive Bar & Kitchen", "Perfect dinner...")
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    Text("Reservation")
                        .font(.largeTitle)
                        .bold()
                    
                    Spacer()
                    NavigationLink("My Bookings") {
                        MyBookingsView()
                    }
                }
                ScrollView {
                    ForEach(restaurants, id: \.1) { item in
                        NavigationLink {
                            PaymentReservationView(restaurantName: item.1)
                        } label: {
                            RestaurantCard(image: item.0, title: item.1, description: item.2)
                        }
                    }
                }
            }
            .padding()
            .toolbar {
               
            }
        }
    }
}

// MARK: - PAYMENT SCREEN
struct PaymentReservationView: View {
    
    let restaurantName: String
    
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(3600)
    @State private var members = 2
    
    @State private var name = ""
    @State private var phone = ""
    
    @State private var paymentMethod = "UPI"
    @State private var navigate = false
    
    let payments = ["UPI", "Credit Card"]
    
    var body: some View {
        VStack(spacing: 15) {
            
            Text("Reserve at \(restaurantName)").bold()
            
            TextField("Enter Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            TextField("Phone Number", text: $phone)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            
            DatePicker("Start Time", selection: $startDate)
            DatePicker("End Time", selection: $endDate)
            
            Stepper("Members: \(members)", value: $members, in: 1...20)
            
            Picker("Payment", selection: $paymentMethod) {
                ForEach(payments, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
            
            Button("Confirm Booking") {
                
                guard !name.isEmpty, !phone.isEmpty, endDate > startDate else { return }
                
                let table = ReservationManager.shared.generateTableNumber()
                
                let reservation = Reservation(
                    restaurantName: restaurantName,
                    startDate: startDate,
                    endDate: endDate,
                    members: members,
                    customerName: name,
                    phoneNumber: phone,
                    tableNumber: table,
                    paymentMethod: paymentMethod
                )
                
                ReservationManager.shared.add(reservation)
                NotificationManager.shared.schedule(for: reservation)
                
                navigate = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            NavigationLink("", isActive: $navigate) {
                SuccessView()
            }
        }
        .padding()
        .onAppear {
            NotificationManager.shared.requestPermission()
        }
    }
}

// MARK: - SUCCESS
struct SuccessView: View {
    var body: some View {
        VStack {
            Text("✅ Booking Confirmed")
                .font(.largeTitle)
            
            NavigationLink("View Bookings") {
                MyBookingsView()
            }
        }
    }
}

// MARK: - BOOKINGS
struct MyBookingsView: View {
    
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

// MARK: - CARD
struct RestaurantCard: View {
    var image: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(image)
                .resizable()
                .frame(height: 150)
            
            Text(title).bold()
            Text(description).font(.caption)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

// MARK: - PREVIEW
#Preview {
    ReservationView()
}
