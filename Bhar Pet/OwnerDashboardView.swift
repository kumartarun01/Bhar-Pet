//
//
//
//import SwiftUI
//
//struct OwnerDashboardView: View {
//    
//    @State private var selectedTab = 0
//    let tabs = ["Preparing (5)", "Ready (1)", "Picked (1)"]
//    
//    var body: some View {
//        
//        VStack(spacing: 15) {
//            
//            // MARK: HEADER
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Outlet Online")
//                        .foregroundColor(.green)
//                        .font(.caption)
//                    
//                    Text("Accepting orders")
//                        .font(.title2)
//                        .bold()
//                }
//                
//                Spacer()
//                
//                Image(systemName: "bell.fill")
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(10)
//                    .shadow(radius: 2)
//            }
//            .padding(.horizontal)
//            
//            
//            // MARK: SEARCH
//            TextField("Search by order id", text: .constant(""))
//                .padding()
//                .background(Color.gray.opacity(0.1))
//                .cornerRadius(12)
//                .padding(.horizontal)
//            
//            
//            // MARK: TABS
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 10) {
//                    ForEach(0..<tabs.count, id: \.self) { index in
//                        Text(tabs[index])
//                            .padding(.vertical, 8)
//                            .padding(.horizontal, 14)
//                            .background(selectedTab == index ? Color.red : Color.gray.opacity(0.2))
//                            .foregroundColor(selectedTab == index ? .white : .black)
//                            .cornerRadius(10)
//                            .onTapGesture {
//                                selectedTab = index
//                            }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            
//            
//            // MARK: ORDER LIST
//            ScrollView {
//                VStack(spacing: 15) {
//                    
//                    OrderCard()
//                    OrderCard()
//                    
//                }
//                .padding(.horizontal)
//            }
//            
//            
//            // MARK: BOTTOM BAR
//            HStack {
//                BottomItem(icon: "list.bullet", title: "Menu")
//                BottomItem(icon: "chart.bar", title: "Business")
//                
//                Spacer()
//                
//                ZStack {
//                    Circle()
//                        .fill(Color.yellow)
//                        .frame(width: 60, height: 60)
//                    
//                    Image(systemName: "bag.fill")
//                        .foregroundColor(.black)
//                }
//                .offset(y: -20)
//                
//                Spacer()
//                
//                BottomItem(icon: "megaphone", title: "Campaigns")
//                BottomItem(icon: "line.3.horizontal", title: "More")
//            }
//            .padding()
//            .background(Color.white)
//        }
//        .background(Color(.systemGray6))
//    }
//}
//
//
//// MARK: - ORDER CARD
//
//struct OrderCard: View {
//    
//    var body: some View {
//        
//        VStack(alignment: .leading, spacing: 10) {
//            
//            HStack {
//                Text("0224 | 6:30 PM")
//                    .font(.headline)
//                
//                Spacer()
//                
//                Image(systemName: "ellipsis")
//            }
//            
//            Text("SAMEER'S 10TH ORDER")
//                .font(.caption)
//                .foregroundColor(.green)
//            
//            Divider()
//            
//            HStack {
//                Text("1 x Butter Chicken")
//                Spacer()
//                Text("₹ 410")
//            }
//            
//            HStack {
//                Text("1 x Garlic Naan")
//                Spacer()
//                Text("₹ 90")
//            }
//            
//            Divider()
//            
//            Text("Total bill: ₹ 500")
//                .foregroundColor(.gray)
//            
//            Button(action: {}) {
//                Text("ORDER READY 01:13")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(
//                        LinearGradient(
//                            colors: [Color.blue, Color.blue.opacity(0.7)],
//                            startPoint: .leading,
//                            endPoint: .trailing
//                        )
//                    )
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//        .background(Color.white)
//        .cornerRadius(15)
//        .shadow(radius: 2)
//    }
//}
//
//
//// MARK: - BOTTOM ITEM
//
//struct BottomItem: View {
//    
//    var icon: String
//    var title: String
//    
//    var body: some View {
//        VStack {
//            Image(systemName: icon)
//            Text(title)
//                .font(.caption)
//        }
//    }
//}
//
//
//// MARK: - PREVIEW
//
//#Preview {
//    OwnerDashboardView()
//}
import SwiftUI
import Combine
struct OrderReservation: Identifiable, Codable {
    let id = UUID()
    var restaurantName: String
    var customerName: String
    var phone: String
    var items: [OrderItem]
    var total: Double
    var status: OrderStatus
}
struct OrderItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var qty: Int
    var price: Double
}

enum OrderStatus: String, Codable, CaseIterable {
    case preparing = "Preparing"
    case ready = "Ready"
    case picked = "Picked"
}

// MARK: - MANAGER (SHARED)

class OrderManager: ObservableObject {
    
    static let shared = OrderManager()
    
    @Published var orders: [OrderReservation] = []
    
    // ADD ORDER (Customer Side)
    func addOrder(_ order: OrderReservation) {
        orders.append(order)
    }
    
    // UPDATE STATUS (Owner Side)
    func updateStatus(id: UUID, status: OrderStatus) {
        guard let index = orders.firstIndex(where: {$0.id == id}) else { return }
        orders[index].status = status
    }
    
    // FILTER BY RESTAURANT
    func orders(for restaurant: String) -> [OrderReservation] {
        orders.filter { $0.restaurantName == restaurant }
    }
}



// MARK: - OWNER VIEW

struct OwnerDashboard: View {
    
    @ObservedObject var manager = OrderManager.shared
    
    var restaurantName: String
    @State private var selected: OrderStatus = .preparing
    
    var body: some View {
        VStack {
            
            // TABS
            HStack {
                ForEach(OrderStatus.allCases, id: \.self) { status in
                    Text(status.rawValue)
                        .padding()
                        .background(selected == status ? Color.red : Color.gray.opacity(0.2))
                        .foregroundColor(selected == status ? .white : .black)
                        .cornerRadius(10)
                        .onTapGesture {
                            selected = status
                        }
                }
            }
            
            // ORDER LIST
            ScrollView {
                ForEach(manager.orders(for: restaurantName).filter{$0.status == selected}) { order in
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(order.customerName).bold()
                        
                        ForEach(order.items) { item in
                            Text("\(item.qty)x \(item.name)")
                        }
                        
                        Text("₹\(order.total, specifier: "%.0f")")
                        
                        Button {
                            nextStatus(order)
                        } label: {
                            Text(buttonTitle(order.status))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Owner")
    }
    
    func nextStatus(_ order: OrderReservation) {
        switch order.status {
        case .preparing:
            manager.updateStatus(id: order.id, status: .ready)
        case .ready:
            manager.updateStatus(id: order.id, status: .picked)
        case .picked:
            break
        }
    }
    
    func buttonTitle(_ status: OrderStatus) -> String {
        switch status {
        case .preparing: return "Mark Ready"
        case .ready: return "Mark Picked"
        case .picked: return "Completed"
        }
    }
}

// MARK: - ADD ORDER DEMO

struct AddOrderView: View {
    
    @ObservedObject var manager = OrderManager.shared
    
    var body: some View {
        VStack(spacing: 20) {
            
            Button("Place Order (Burger Hub)") {
                
                let order = OrderReservation(
                    restaurantName: "Burger Hub",
                    customerName: "Kaptan",
                    phone: "9876543210",
                    items: [
                        OrderItem(name: "Burger", qty: 2, price: 120),
                        OrderItem(name: "Fries", qty: 1, price: 80)
                    ],
                    total: 320,
                    status: .preparing
                )
                
                manager.addOrder(order)
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

// MARK: - ROOT VIEW

struct RootTabView: View {
    
    var body: some View {
        TabView {
            
           
            
            NavigationStack {
                OwnerDashboard(restaurantName: "Burger Hub")
            }
            .tabItem {
                Label("Owner", systemImage: "storefront")
            }
            
            AddOrderView()
                .tabItem {
                    Label("Add", systemImage: "plus")
                }
        }
    }
}

// MARK: - PREVIEW

#Preview {
    RootTabView()
}

