import SwiftUI

struct OrderHistoryView2: View {
    
    @ObservedObject var manager = CartManager2.shared
    
    var body: some View {
        List {
            ForEach(manager.orders) { order in
                VStack(alignment: .leading) {
                    Text("Order Total: ₹\(order.total)")
                        .bold()
                    
                    ForEach(order.items) { item in
                        Text("\(item.food.name) x \(item.quantity)")
                    }
                }
            }
        }
    }
}

#Preview {
    OrderHistoryView2()
}
