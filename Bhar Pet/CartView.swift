import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    var totalPrice: Double {
        cartManager.items.reduce(0) {
            $0 + ($1.price * Double($1.quantity))
        }
    }
    
    var body: some View {
        
        ZStack {
            Color(.systemGray6).ignoresSafeArea()
            
            VStack {
                
                Text("My Cart")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                if cartManager.items.isEmpty {
                    Spacer()
                    Text("Your cart is empty")
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    
                    List {
                        ForEach($cartManager.items) { $item in
                            
                            HStack {
                                
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text("₹\(Int(item.price))")
                                        .foregroundColor(.gray)
                                }
                                
                                Spacer()
                                
                                Stepper(
                                    value: $item.quantity,
                                    in: 1...10
                                ) {
                                    Text("\(item.quantity)")
                                }
                            }
                        }
                    }
                    
                    HStack {
                        Text("Total")
                            .bold()
                        Spacer()
                        Text("₹\(Int(totalPrice))")
                            .bold()
                            .foregroundColor(.green)
                    }
                    .padding()
                }
            }
        }
    }
}

//#Preview {
    struct CartView_Previews: PreviewProvider {
        static var previews: some View {
            CartView()
                .environmentObject(CartManager())
        }
    }
        
//}
