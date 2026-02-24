//
//  NonVegBurgerView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct NonVegBurgerView: View {
    
    @State private var goToCart = false
    
    @EnvironmentObject var cartManager: CartManager
    
    let prices: [String: Double] = [
        "Chicken Burger": 120,
        "Chicken Paneer": 140,
        "Cheese Chicken": 150,
        "Chicken KFG": 160,
        "Deep Fry Burger": 130
    ]
    
    let categories = [
        "Chicken Burger",
        "Chicken Paneer",
        "Cheese Chicken",
        "Chicken KFG",
        "Deep Fry Burger"
    ]
    
    @State private var selectedItems: Set<String> = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                VStack {
                    
                    VStack(alignment: .leading) {
                        
                        // Back Button
                        Button(action: {
                            // Back Action
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .foregroundColor(.blue)
                        }
                        .padding(.leading)
                        .padding(.top, 10)
                        
                        // Heading
                        Text("Chicken Burger")
                            .font(.custom("Snell Roundhand", size: 36))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 5)
                        
                        // Burger Image
                        Image("Burger")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                            .padding(.horizontal, 30)
                        
                        // Category Title
                        Text("Category")
                            .font(.custom("Snell Roundhand", size: 28))
                            .padding(.leading, 30)
                            .padding(.top, 10)
                        
                        // Checkbox List
                        VStack(spacing: 12) {
                            ForEach(categories, id: \.self) { item in
                                
                                Button(action: {
                                    if selectedItems.contains(item) {
                                        selectedItems.remove(item)
                                    } else {
                                        selectedItems.insert(item)
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: selectedItems.contains(item) ? "checkmark.square.fill" : "square")
                                            .foregroundColor(.green)
                                        
                                        Text(item)
                                            .foregroundColor(.black.opacity(0.8))
                                            .font(.system(size: 18, weight: .semibold))
                                        
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color(red: 0.68, green: 0.78, blue: 0.77))
                                    .cornerRadius(15)
                                    .padding(.horizontal, 30)
                                }
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            for item in selectedItems {
                                if let price = prices[item] {
                                    cartManager.addItem(name: item, price: price)
                                }
                            }
                            goToCart = true
                        } label: {
                            Text("Add To Cart")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(selectedItems.isEmpty ? Color.gray : Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .padding(.horizontal, 30)
                                .padding(.bottom, 20)
                        }
                        .disabled(selectedItems.isEmpty)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $goToCart) {
                CartView()
            }
        }
    }
}

//#Preview {
    struct NonVegBurgerView_Previews: PreviewProvider {
        static var previews: some View {
            NonVegBurgerView()
                .environmentObject(CartManager())
        }
    }
//}

