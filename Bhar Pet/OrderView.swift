//
//  OrderView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct OrderView: View {
    
    @State private var quantity: String = ""
    @State private var phoneNumber: String = ""
    @State private var location: String = ""
    @State private var address: String = ""
    @State private var cashOnDelivery: Bool = false
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                
                // Main Card
                VStack(alignment: .leading, spacing: 20) {
                    
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
                    
                    // Heading
                    Text("Your Order")
                        .font(.largeTitle)
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.bottom, 20)
                    
                    // TextFields
                    Group {
                        CustomTextField(placeholder: "How much quantity you need", text: $quantity)
                        CustomTextField(placeholder: "Phone number", text: $phoneNumber)
                        CustomTextField(placeholder: "Near By location", text: $location)
                        
                        TextField("Address", text: $address)
                            .frame(height: 100)
                            .padding()
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.gray.opacity(0.6))
                            )
                    }
                    
                    // Toggle
                    Toggle(isOn: $cashOnDelivery) {
                        Text("Cash on Delivery")
                            .foregroundColor(.blue)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: .gray))
                    
                    Spacer()
                    
                    // Order Button
                    Button(action: {
                        print("Order Placed")
                    }) {
                        Text("Order")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.blue.opacity(0.7), Color.blue]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 20)
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.6))
            )
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
    }
}
