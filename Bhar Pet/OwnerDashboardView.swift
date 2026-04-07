//
//  OwnerDashboardView.swift
//  Bhar Pet
//
//  Created by iMac1 on 07/04/26.
//

import SwiftUI
import FirebaseAuth

struct OwnerDashboardView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Welcome Owner 👑")
                .font(.largeTitle)
            
            Button("Logout") {
                try? Auth.auth().signOut()
            }
        }
    }
}
