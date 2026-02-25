//
//  NotificationView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct NotificationView: View {
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                
                // Main iPhone Style Container
                VStack(alignment: .leading) {
                    
//                    // Back Button
//                    Button(action: {
//                        // Back action
//                    }) {
//                        HStack {
//                            Image(systemName: "chevron.left")
//                            Text("Back")
//                        }
//                        .foregroundColor(.blue)
//                    }
//                    .padding(.top, 20)
                    
                    // Heading
                    Text("Notifications")
                        .font(.custom("Snell Roundhand", size: 34))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10)
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
