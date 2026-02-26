//
//  CardDetailsView.swift
//  Bhar Pet
//
//  Created by iMac1 on 26/02/26.
//

import SwiftUI

struct CardDetailsView: View {
    
    @State private var cardNumber: String = ""
    @State private var cardHolderName: String = ""
    @State private var month: String = ""
    @State private var year: String = ""
    @State private var cvv: String = ""
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .leading, spacing: 20) {
                    
                    // MARK: Title
                    Text("Payment Details")
                        .font(.title3)
                        .bold()
                    
                    // MARK: Card Number
                    ZStack(alignment: .trailing) {
                        
                        TextField("CARD NUMBER", text: $cardNumber)
                            .padding()
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4))
                            )
                            .cornerRadius(8)
                        
                        Rectangle()
                            .fill(Color.blue.opacity(0.8))
                            .frame(width: 40, height: 28)
                            .cornerRadius(4)
                            .padding(.trailing, 10)
                    }
                    
                    // MARK: Cardholder Name
                    TextField("CARDHOLDER NAME", text: $cardHolderName)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.4))
                        )
                        .cornerRadius(8)
                    
                    // MARK: Expiry + CVV
                    HStack(spacing: 15) {
                        
                        TextField("Month", text: $month)
                            .padding()
                            .frame(width: 80)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4))
                            )
                            .cornerRadius(8)
                        
                        TextField("Exp Date", text: $year)
                            .padding()
                            .frame(width: 100)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4))
                            )
                            .cornerRadius(8)
                        
                        ZStack(alignment: .trailing) {
                            
                            TextField("CVV", text: $cvv)
                                .padding()
                                .frame(width: 100)
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray.opacity(0.4))
                                )
                                .cornerRadius(8)
                            
                            Image(systemName: "creditcard")
                                .padding(.trailing, 10)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    // MARK: Buttons
//                    HStack(spacing: 15) {
//                        
//                        Button(action: {
//                            print("Confirm tapped")
//                        }) {
//                            Text("CONFIRM AND PAY ")
//                                .foregroundColor(.white)
//                                .frame(height: 45)
//                                .frame(maxWidth: .infinity)
//                                .background(Color.blue)
//                                .cornerRadius(8)
//                        }
//                        
//                        Button(action: {
//                            print("Cancel tapped")
//                        }) {
//                            Text("CANCEL")
//                                .foregroundColor(Color.blue)
//                                .frame(height: 45)
//                                .frame(width: 100)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(Color.blue, lineWidth: 1.5)
//                                )
//                        }
//                    }
                }
                .padding(25)
//                .background(Color(.systemGray5))
                .cornerRadius(12)
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CardDetailsView()
    }
}
