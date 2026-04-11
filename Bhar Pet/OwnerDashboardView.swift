

import SwiftUI
import Combine

// MARK: - MODELS (Codable for persistence)

struct OrderReservation: Identifiable, Codable {
    var id: UUID = UUID()
    var restaurantName: String
    var customerName: String
    var phone: String
    var items: [OrderItem]
    var total: Double
    var status: OrderStatus
}

struct OrderItem: Identifiable, Codable {
    var id: UUID = UUID()
    var name: String
    var qty: Int
    var price: Double
}

enum OrderStatus: String, Codable, CaseIterable {
    case preparing = "Preparing"
    case ready = "Ready"
    case picked = "Picked"
}

// MARK: - MANAGER (Shared + Persistent)

class OrderManager: ObservableObject {
    
    static let shared = OrderManager()
    
    @Published var orders: [OrderReservation] = [] {
        didSet { save() }
    }
    
    private let saveKey = "BharPetOrders"
    
    private init() {
        load()
    }
    
    // ADD ORDER (Customer Side)
    func addOrder(_ order: OrderReservation) {
        orders.append(order)
    }
    
    // UPDATE STATUS (Owner Side)
    func updateStatus(id: UUID, status: OrderStatus) {
        guard let index = orders.firstIndex(where: { $0.id == id }) else { return }
        orders[index].status = status
    }
    
    // FILTER BY STATUS
    func orders(for restaurantName: String) -> [OrderReservation] {
        orders.filter { $0.restaurantName == restaurantName }
    }
    
    // SAVE to UserDefaults (persist after logout)
    private func save() {
        if let encoded = try? JSONEncoder().encode(orders) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    // LOAD from UserDefaults
    private func load() {
        if let data = UserDefaults.standard.data(forKey: saveKey),
           let decoded = try? JSONDecoder().decode([OrderReservation].self, from: data) {
            orders = decoded
        }
    }
}

// MARK: - OWNER DASHBOARD VIEW

struct OwnerDashboard: View {
    
    @ObservedObject var manager = OrderManager.shared
    @State private var selected: OrderStatus = .preparing
    @State private var searchText = ""
    
    // Callback to go back to AdminUserView (logout)
    var onLogout: () -> Void
    
    var restaurantName: String = "Bhar Pet"
    
    var filteredOrders: [OrderReservation] {
        let statusFiltered = manager.orders(for: restaurantName).filter { $0.status == selected }
        if searchText.isEmpty { return statusFiltered }
        return statusFiltered.filter {
            $0.customerName.localizedCaseInsensitiveContains(searchText) ||
            $0.id.uuidString.prefix(4).localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            // MARK: HEADER
            HStack {
                VStack(alignment: .leading) {
                    Text("Outlet Online")
                        .foregroundColor(.green)
                        .font(.caption)
                    Text("Accepting Orders")
                        .font(.title2)
                        .bold()
                }
                Spacer()
                
                // LOGOUT BUTTON
                Button(action: {
                    onLogout()
                }) {
                    HStack(spacing: 4) {
                        Image(systemName: "arrow.backward.square")
                        Text("Logout")
                            .font(.caption)
                            .bold()
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.red)
                    .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.white)
            .shadow(radius: 1)
            
            // MARK: SEARCH
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search by customer name...", text: $searchText)
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.top, 10)
            
            // MARK: STATUS TABS with counts
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(OrderStatus.allCases, id: \.self) { status in
                        let count = manager.orders(for: restaurantName).filter { $0.status == status }.count
                        Text("\(status.rawValue) (\(count))")
                            .padding(.vertical, 8)
                            .padding(.horizontal, 14)
                            .background(selected == status ? Color.red : Color.gray.opacity(0.2))
                            .foregroundColor(selected == status ? .white : .black)
                            .cornerRadius(10)
                            .onTapGesture {
                                selected = status
                            }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 8)
            
            // MARK: ORDER LIST
            if filteredOrders.isEmpty {
                Spacer()
                VStack(spacing: 12) {
                    Image(systemName: "tray")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.4))
                    Text("No \(selected.rawValue) orders")
                        .foregroundColor(.gray)
                }
                Spacer()
            } else {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(filteredOrders) { order in
                            OwnerOrderCard(order: order) { newStatus in
                                manager.updateStatus(id: order.id, status: newStatus)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .background(Color(.systemGray6))
    }
}

// MARK: - ORDER CARD

struct OwnerOrderCard: View {
    
    let order: OrderReservation
    var onStatusChange: (OrderStatus) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Text(order.customerName)
                    .font(.headline)
                Spacer()
                Text("#\(order.id.uuidString.prefix(4).uppercased())")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Divider()
            
            ForEach(order.items) { item in
                HStack {
                    Text("\(item.qty) x \(item.name)")
                    Spacer()
                    Text("₹\(Int(item.price * Double(item.qty)))")
                        .foregroundColor(.gray)
                }
            }
            
            Divider()
            
            HStack {
                Text("Total Bill:")
                    .foregroundColor(.gray)
                Spacer()
                Text("₹\(Int(order.total))")
                    .bold()
                    .foregroundColor(.green)
            }
            
            // Status Badge
            HStack {
                Circle()
                    .fill(statusColor(order.status))
                    .frame(width: 8, height: 8)
                Text(order.status.rawValue)
                    .font(.caption)
                    .foregroundColor(statusColor(order.status))
                Spacer()
            }
            
            // Action Button
            if order.status != .picked {
                Button(action: {
                    onStatusChange(nextStatus(order.status))
                }) {
                    Text(buttonTitle(order.status))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [Color.blue, Color.blue.opacity(0.7)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("Order Completed")
                        .foregroundColor(.green)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
    
    func statusColor(_ status: OrderStatus) -> Color {
        switch status {
        case .preparing: return .orange
        case .ready: return .blue
        case .picked: return .green
        }
    }
    
    func nextStatus(_ status: OrderStatus) -> OrderStatus {
        switch status {
        case .preparing: return .ready
        case .ready: return .picked
        case .picked: return .picked
        }
    }
    
    func buttonTitle(_ status: OrderStatus) -> String {
        switch status {
        case .preparing: return "✅ Mark Ready"
        case .ready: return "🚀 Mark Picked"
        case .picked: return "Completed"
        }
    }
}

// MARK: - ROOT TAB VIEW (for OwnerLoginView)

struct RootTabView: View {
    var onLogout: () -> Void = {}
    
    var body: some View {
        OwnerDashboard(onLogout: onLogout)
    }
}

// MARK: - PREVIEW

#Preview {
    OwnerDashboard(onLogout: {})
}
