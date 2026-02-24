//
//  CartManager.swift
//  Bhar Pet
//
//  Created by iMac1 on 24/02/26.
//

import SwiftUI
import Combine

class CartManager: ObservableObject {
    
    @Published var items: [CartItem] = []
    
    func addItem(name: String, price: Double) {
        
        if let index = items.firstIndex(where: { $0.name == name }) {
            items[index].quantity += 1
        } else {
            let newItem = CartItem(name: name, price: price, quantity: 1)
            items.append(newItem)
        }
    }
}
