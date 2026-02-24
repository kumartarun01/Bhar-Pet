//
//  OmeletteView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct OmeletteView: View {
    
    let categories = [
        "Bread Omelette",
        "Half Frie Omelette",
        "Cheese Omelette"
    ]
    
    @State private var selectedItems: Set<String> = []
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                
                ZStack(alignment: .top) {
                    
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
                        Text("Omelette")
                            .font(.custom("Snell Roundhand", size: 36))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 5)
                        
                        // Omelette Image
                        Image("omelette")
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
                        
                        // Add To Cart Button
                        Button(action: {
                            print("Selected Items:", selectedItems)
                        }) {
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
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct OmeletteView_Previews: PreviewProvider {
    static var previews: some View {
        OmeletteView()
    }
}
