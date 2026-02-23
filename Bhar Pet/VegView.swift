//
//  VegView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct VegView: View {
    
    let items = [
        FoodItem(name: "Burger", image: "Burger"),
        FoodItem(name: "Chilli Potato", image: "Chilli patato"),
        FoodItem(name: "Momos", image: "Momos"),
        FoodItem(name: "Pizza", image: "Pizza"),
        FoodItem(name: "Rice", image: "Rice"),
        FoodItem(name: "Sandwich", image: "Sandwich"),
        FoodItem(name: "Chowmein", image: "Chowmein"),
        FoodItem(name: "Dosa", image: "Dosa")
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
                        Button(action: {
                            // Back action
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Back")
                            }
                            .foregroundColor(.blue)
                        }
                        .padding(.leading)
                        
                        // Heading
                        Text("Vegetarian")
                            .font(.custom("Snell Roundhand", size: 32))
                            .padding(.leading, 120)
                            .padding(.bottom, 10)
                        
                        // Grid
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(items) { item in
                                VStack {
                                    Image(item.image)
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

struct FoodItem: Identifiable {
    let id = UUID()
    let name: String
    let image: String
}

struct VegView_Previews: PreviewProvider {
    static var previews: some View {
        VegView()
    }
}
