//
//  CartView.swift
//  Bhar Pet
//
//  Created by iMac1 on 24/02/26.
//

//import SwiftUI
//
//struct CartItem: Identifiable {
//    let id = UUID()
//    let name: String
//    let price: Double
//    var quantity: Int
//}
//
//struct CartView: View {
//    
//    @State var cartItems: [CartItem] = [
//        CartItem(name: "Bread Omelette", price: 40, quantity: 1),
//        CartItem(name: "Cheese Omelette", price: 60, quantity: 1)
//    ]
//    
//    var totalPrice: Double {
//        cartItems.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
//    }
//    
//    var body: some View {
//        
//        NavigationStack {
//            ZStack {
//                Color(.systemGray6)
//                    .ignoresSafeArea()
//                
//                VStack {
//                    
//                    Text("My Cart")
//                        .font(.largeTitle)
//                        .bold()
//                        .padding()
//                    
//                    ScrollView {
//                        VStack(spacing: 15) {
//                            
//                            ForEach($cartItems) { $item in
//                                
//                                VStack {
//                                    
//                                    HStack {
//                                        
//                                        VStack(alignment: .leading) {
//                                            Text(item.name)
//                                                .font(.headline)
//                                            
//                                            Text("₹\(Int(item.price))")
//                                                .foregroundColor(.gray)
//                                        }
//                                        
//                                        Spacer()
//                                        
//                                        // Quantity Controls
//                                        HStack {
//                                            
//                                            Button {
//                                                if item.quantity > 1 {
//                                                    item.quantity -= 1
//                                                }
//                                            } label: {
//                                                Image(systemName: "minus.circle.fill")
//                                                    .font(.title2)
//                                                    .foregroundColor(.red)
//                                            }
//                                            
//                                            Text("\(item.quantity)")
//                                                .font(.headline)
//                                                .frame(width: 30)
//                                            
//                                            Button {
//                                                item.quantity += 1
//                                            } label: {
//                                                Image(systemName: "plus.circle.fill")
//                                                    .font(.title2)
//                                                    .foregroundColor(.green)
//                                            }
//                                        }
//                                    }
//                                    .padding()
//                                }
//                                .background(.white)
//                                .cornerRadius(15)
//                                .padding(.horizontal)
//                            }
//                        }
//                    }
//                    
//                    // Total Section
//                    VStack {
//                        
//                        HStack {
//                            Text("Total")
//                                .font(.title3)
//                                .bold()
//                            
//                            Spacer()
//                            
//                            Text("₹\(Int(totalPrice))")
//                                .font(.title3)
//                                .bold()
//                                .foregroundColor(.green)
//                        }
//                        .padding()
//                        
//                        NavigationLink{
//                            OrderView()
//                        }label: {
//                            Text("Proceed to Checkout")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.green)
//                                .foregroundColor(.white)
//                                .cornerRadius(20)
//                                .padding()
//                        }
//                        
////                        Button(action: {
////                            print("Proceed to Checkout")
////                        }) {
////                            Text("Proceed to Checkout")
////                                .frame(maxWidth: .infinity)
////                                .padding()
////                                .background(Color.green)
////                                .foregroundColor(.white)
////                                .cornerRadius(20)
////                                .padding()
////                        }
//                    }
//                    .background(.white)
//                    .cornerRadius(25)
//                    .padding()
//                }
//            }
//        }
//    }
//}

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
