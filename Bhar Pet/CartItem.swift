//
//  CartItem.swift
//  Bhar Pet
//
//  Created by iMac1 on 24/02/26.
//

import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    var quantity: Int
}
