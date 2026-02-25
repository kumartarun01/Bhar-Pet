//
//  AboutView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct AboutView: View {
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                
                // iPhone Style Container
                ZStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        
//                        // Back Button
//                        Button(action: {
//                            // Back Action
//                        }) {
//                            HStack {
//                                Image(systemName: "chevron.left")
//                                Text("Back")
//                            }
//                            .foregroundColor(.blue)
//                        }
//                        .padding(.leading)
//                        .padding(.top, 10)
                        
                        // Heading
                        Text("About")
                            .font(.custom("Snell Roundhand", size: 36))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                        
                        Spacer()
                        
                        // About Text
                        Text("""
Findurant is your ultimate dining companion, designed to make finding the perfect restaurant effortless. Whether you're craving local favorites or exploring new culinary experiences, Findurant helps you discover the best places to eat based on your preferences, location, and dietary needs.

With easy-to-use features like real-time reviews, menus, and reservation options, Findurant lets you explore a wide variety of dining choices, all in one place. From casual bites to fine dining, we’ve got you covered—making every meal memorable and every decision simple.
""")
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black.opacity(0.85))
                        .padding(.horizontal, 30)
                        
                        Spacer()
                    }
                }
                .padding()
                .frame(height: 750)
                
                Spacer()
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
