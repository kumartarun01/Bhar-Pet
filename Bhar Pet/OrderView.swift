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
    
    @State private var selectedPayment: PaymentMethod? = nil
    
    enum PaymentMethod: String, CaseIterable {
        case upi = "UPI / BHIM / PhonePe / Google Pay"
        case creditCard = "CREDIT CARD"
        case debitCard = "DEBIT CARD"
        case wallets = "WALLETS"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Back Button
                       NavigationLink {
                            CartView()
                        }label: {
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
                            .padding(.bottom, 10)
                        
                        // TextFields
                        Group {
                            CustomTextField(placeholder: "Name", text: $quantity)
                            CustomTextField(placeholder: "Phone number", text: $phoneNumber)
                            ZStack {
                                CustomTextField(placeholder: "Near By location", text: $location)
                                NavigationLink {
                                    MapView()
                                }label: {
                                    Image(systemName: "mappin.and.ellipse")    
                                }.padding(EdgeInsets(top: 0, leading: 150, bottom: 0, trailing: -150))
                            }
                            TextField("Address", text: $address)
                                .frame(height: 100)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.gray.opacity(0.6))
                                )
                        }
                        
                        // MARK: - Payment Section
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text("Select a Payment Method")
                                .font(.headline)
                                .foregroundColor(.gray)
                            
                            ForEach(PaymentMethod.allCases, id: \.self) { method in
                                
                                Button(action: {
                                    selectedPayment = method
                                }) {
                                    Text(method.rawValue)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.blue)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 55)
                                        .background(Color.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(
                                                    selectedPayment == method ?
                                                    Color.blue :
                                                    Color.blue.opacity(0.5),
                                                    lineWidth: 2
                                                )
                                        )
                                }
                            }
                        }
                        .padding(.top, 10)
                        
                        // Order Button
                        Button(action: {
                            print("Order placed with \(selectedPayment?.rawValue ?? "No Payment Selected")")
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
                        .padding(.top, 20)
                    }
                    .padding()
                }
            }
        }.toolbar(.hidden)
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
