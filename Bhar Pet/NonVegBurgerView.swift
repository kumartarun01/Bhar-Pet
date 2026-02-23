//
//  NonVegBurgerView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct NonVegBurgerView: View {
    
    let categories = [
        "Chicken Burgre",
        "Chicken Paneer",
        "Cheese Chicken",
        "chicken KFG",
        "Deep Firy Burger"
    ]
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                
                // iPhone Style Container
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
                        Text("Chicken Burger")
                            .font(.custom("Snell Roundhand", size: 36))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 5)
                        
                        // Burger Image
                        Image("Burger") // Add burger image in Assets
                            .resizable()
                            .scaledToFill()
                            .frame(height: 250)
                            .clipped()
                            .padding(.horizontal, 30)
                        
                        // Category Title
                        Text("Catagory")
                            .font(.custom("Snell Roundhand", size: 28))
                            .padding(.leading, 30)
                            .padding(.top, 10)
                        
                        // Category Buttons
                        VStack(spacing: 12) {
                            ForEach(categories, id: \.self) { item in
                                Text(item)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(Color(red: 0.68, green: 0.78, blue: 0.77))
                                    .cornerRadius(20)
                                    .padding(.horizontal, 30)
                            }
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                .frame(height: 800)
                
                Spacer()
            }
        }
    }
}

struct NonVegBurgerView_Previews: PreviewProvider {
    static var previews: some View {
        NonVegBurgerView()
    }
}
