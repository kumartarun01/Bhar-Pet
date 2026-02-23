//
//  NonVegView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct NonVegView: View {
    
    let items: [NonVegFoodItem] = [
        NonVegFoodItem(name: "Burger", image: "Burger"),
        NonVegFoodItem(name: "Omelette", image: "omelette"),
        NonVegFoodItem(name: "Momos", image: "Momos"),
        NonVegFoodItem(name: "Pizza", image: "Pizza"),
        NonVegFoodItem(name: "Rice", image: "Rice"),
        NonVegFoodItem(name: "Sandwich", image: "Sandwich"),
        NonVegFoodItem(name: "Chicken", image: "Chicken")
    ]
    
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: .infinity)),
        GridItem(.flexible(minimum: 100, maximum: .infinity))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        // Back Button
//                        Button(action: {
//                            // Back action
//                        }) {
//                            HStack {
//                                Image(systemName: "chevron.left")
//                                Text("Back")
//                            }
//                            .foregroundColor(.blue)
//                        }
//                        .padding(.leading)
                        
                        // Heading
//                        Text("Non Vegetarian")
//                            .font(.custom("Snell Roundhand", size: 32))
//                            .padding(.leading, 100)
//                            .padding(.bottom, 10)
                        
                        // Grid
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(items) { item in
                                VStack {
                                    Image(item.image, bundle: .main)
                                        .resizable()
//                                        .scaledToFill()
                                        .frame(height: 150)
                                        .clipped()
                                        .cornerRadius(8)
                                    
                                    Text(item.name)
                                        .font(.headline)
                                        .padding(.top, 5)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .background(Color(.systemGray6))
        }
    }
}

struct NonVegFoodItem: Identifiable {
    let id = UUID()
    let name: String
    let image: String
}
#Preview {
    NonVegView()
}
