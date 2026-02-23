//
//  HomeView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selection: Int = 0
    
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
                
                Picker("Auth", selection: $selection) {
                                Text("Veg").tag(0)
                                Text("Non Veg").tag(1)
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal)
                if selection == 0 {
                                VegView()
                                
                            }
                            else{
                                NonVegView()
                            }
            }.background(Color(.systemGray6))
        }.toolbar(.hidden)
    }
}
#Preview {
    HomeView()
}
