//
//  HomeView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct HomeView: View {
    
    let items = [
        ("Cake", "cake"),
        ("Burger", "Burger"),
        ("Chilli Potato", "Chilli patato"),
        ("Ice Cream", "icecream"),
        ("Juice", "juices"),
        ("Momos", "Momos")
    ]
    
    let columns = [
        GridItem(.flexible(minimum: 100, maximum: .infinity)),
        GridItem(.flexible(minimum: 100, maximum: .infinity))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home")
                    .font(Font.largeTitle.bold())
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("Search", text: .constant(""))
                    
                    Image(systemName: "mic.fill")
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
                .padding(10)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(items, id: \.0) { item in
                            VStack(spacing: 10) {
                                Image(item.1) // Add images in Assets
                                    .resizable()
                                    .frame(height: 100)
                                    .clipped()
                                    .cornerRadius(5)
                                
                                Text(item.0)
                                    .font(.headline)
                            }
                        }
                    }
                    .padding()
                }
            }
        }.toolbar(.hidden)
    }
}
#Preview {
    HomeView()
}
