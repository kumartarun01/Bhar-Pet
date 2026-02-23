import SwiftUI

//
//  YourOrderView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

struct YourOrderView: View {
    
    let orders = [
        "Pizza - ₹299",
        "Burger - ₹149",
        "Pasta - ₹249"
    ]
    
    var body: some View {
        List(orders, id: \.self) { order in
            Text(order)
        }
        .navigationTitle("Your Order")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    NavigationStack {
        YourOrderView()
    }
}

