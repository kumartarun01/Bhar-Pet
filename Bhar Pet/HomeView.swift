import SwiftUI
import Combine

// MARK: - MODEL
struct FoodItem2: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let image: String
    let price: Int
}

struct CartItem2: Identifiable {
    let id = UUID()
    let food: FoodItem2
    var quantity: Int
}

struct Order2: Identifiable {
    let id = UUID()
    let items: [CartItem2]
    let total: Int
}

// MARK: - MANAGER
class CartManager2: ObservableObject {
    
    static let shared = CartManager2()
    
    @Published var cart: [CartItem2] = []
    @Published var orders: [Order2] = []
    
    func addToCart(food: FoodItem2, qty: Int) {
        if let index = cart.firstIndex(where: { $0.food == food }) {
            cart[index].quantity += qty
        } else {
            cart.append(CartItem2(food: food, quantity: qty))
        }
    }
    
    func totalPrice() -> Int {
        cart.reduce(0) { $0 + ($1.quantity * $1.food.price) }
    }
    
    func placeOrder() {
        let order = Order2(items: cart, total: totalPrice())
        orders.append(order)
        cart.removeAll()
    }
}

// MARK: - HOME
struct HomeView: View {
    
    @State private var searchText = ""
    
    let items: [FoodItem2] = [
        FoodItem2(name: "Cake", image: "cake", price: 250),
        FoodItem2(name: "Burger", image: "Burger", price: 120),
        FoodItem2(name: "Chilli Potato", image: "Chilli patato", price: 180),
        FoodItem2(name: "Ice Cream", image: "icecream", price: 90),
        FoodItem2(name: "Juice", image: "juices", price: 70),
        FoodItem2(name: "Momos", image: "Momos", price: 150)
    ]
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var filteredItems: [FoodItem2] {
        searchText.isEmpty ? items :
        items.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HStack {
                    Text("Home").font(.largeTitle.bold())
                   
                   
                }
                .padding(.horizontal)
                
                // SEARCH
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search food...", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding()
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(filteredItems) { item in
                            NavigationLink {
                                HomeOrderView(food: item)
                            } label: {
                                FoodCard(item: item)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

// MARK: - CARD
struct FoodCard: View {
    let item: FoodItem2
    
    var body: some View {
        VStack {
            Image(item.image)
                .resizable()
                .frame(height: 120)
            
            Text(item.name).bold()
            Text("₹\(item.price)")
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

// MARK: - ORDER SCREEN
struct HomeOrderView: View {
    
    let food: FoodItem2
    @State private var qty = 1
    
    var body: some View {
        VStack(spacing: 20) {
            
            Image(food.image)
                .resizable()
                .frame(height: 200)
            
            Text(food.name).font(.largeTitle).bold()
            Text("₹\(food.price)").foregroundColor(.green)
            
            Stepper("Quantity: \(qty)", value: $qty, in: 1...10)
            
            Button("🛒 Add to Cart") {
                CartManager2.shared.addToCart(food: food, qty: qty)
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            NavigationLink("💳 Go to Cart") {
                CartView2()
            }
            
            Spacer()
        }
        .padding()
    }
}

// MARK: - CART
struct CartView2: View {
    
    @ObservedObject var manager = CartManager2.shared
    @State private var goPayment = false
    
    var body: some View {
        VStack {
            
            List {
                ForEach(manager.cart) { item in
                    HStack {
                        Text(item.food.name)
                        Spacer()
                        Text("₹\(item.food.price) x \(item.quantity)")
                    }
                }
            }
            
            Text("Total: ₹\(manager.totalPrice())")
                .font(.title2)
                .bold()
            
            Button("💳 Proceed to Payment") {
                goPayment = true
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            NavigationLink("", isActive: $goPayment) {
                PaymentView2()
            }
        }
    }
}

// MARK: - PAYMENT
struct PaymentView2: View {
    
    @State private var goSuccess = false
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Payment").font(.largeTitle)
            
            Text("Choose Payment Method")
            
            Button("Pay Now") {
                CartManager2.shared.placeOrder()
                goSuccess = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            
            NavigationLink("", isActive: $goSuccess) {
                OrderSuccessView()
            }
        }
    }
}

// MARK: - SUCCESS
struct OrderSuccessView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Text("✅ Order Placed Successfully")
                .font(.largeTitle)
            
            NavigationLink("📦 View Orders") {
                OrderHistoryView2()
            }
        }
    }
}

// MARK: - ORDER HISTORY

// MARK: - PREVIEW
#Preview {
    HomeView()
}
