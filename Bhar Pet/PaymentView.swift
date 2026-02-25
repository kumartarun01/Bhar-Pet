//
//  PaymentView.swift
//  Bhar Pet
//
//  Created by iMac1 on 25/02/26.
//

import SwiftUI

struct PaymentView: View {
    
    @State private var selectedMethod: String = "UPI"
    @State private var upiID: String = ""
    
    var body: some View {
        VStack(spacing: 25) {
            
            // MARK: Payment Methods Row
            HStack(spacing: 15) {
                
                PaymentOptionView(
                    title: "Credit/Debit Card",
                    imageName: "creditcard.fill",
                    isSelected: selectedMethod == "Card"
                ) {
                    selectedMethod = "Card"
                }
                
                PaymentOptionView(
                    title: "Netbanking",
                    imageName: "building.columns.fill",
                    isSelected: selectedMethod == "Netbanking"
                ) {
                    selectedMethod = "Netbanking"
                }
                
                PaymentOptionView(
                    title: "UPI",
                    imageName: "indianrupeesign",
                    isSelected: selectedMethod == "UPI"
                ) {
                    selectedMethod = "UPI"
                }
                
                PaymentOptionView(
                    title: "Paytm Wallet",
                    imageName: "wallet.pass.fill",
                    isSelected: selectedMethod == "Paytm"
                ) {
                    selectedMethod = "Paytm"
                }
            }
            .padding(.top, 20)
            
            // MARK: UPI TextField
            if selectedMethod == "UPI" {
                TextField("Enter UPI ID", text: $upiID)
                    .padding()
                    .frame(height: 55)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.horizontal)
            }
            
            // MARK: Proceed Button
            Button(action: {
                print("Proceed tapped")
            }) {
                Text("Proceed to payment")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.yellow.opacity(0.6))
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .padding(.top, 10)
            
            Spacer()
        }
        .background(Color(.systemGray6))
    }
}

struct PaymentOptionView: View {
    
    var title: String
    var imageName: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: imageName)
                    .font(.title2)
                    .foregroundColor(.black)
                
                Text(title)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
            }
            .frame(width: 80, height: 80)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(isSelected ? Color.blue : Color.gray.opacity(0.3), lineWidth: 2)
            )
            .cornerRadius(8)
        }
    }
}

#Preview {
    PaymentView()
}

