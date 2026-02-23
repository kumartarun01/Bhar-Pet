import SwiftUI
//
//  HistoryView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

struct OrderHistoryView: View {
    
    let historyItems = [
        "Order #1234 - Delivered",
        "Order #5678 - Cancelled",
        "Order #9101 - Delivered"
    ]
    
    var body: some View {
        List(historyItems, id: \.self) { item in
            Text(item)
        }
        .navigationTitle("History")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    OrderHistoryView()
}
