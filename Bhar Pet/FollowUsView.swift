//
//  FollowUsView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct FollowUsView: View {
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                
                // Top VC Label
//                Text("FollowusVC")
//                    .font(.headline)
//                    .padding(.top, 10)
                
                Spacer()
                
                // iPhone Style Container
                ZStack(alignment: .top) {
                    
                    // Background Image
                    Image("followbg") // Add this image in Assets
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 45))
                    
                    VStack {
                        
                        // Dynamic Island
//                        Capsule()
//                            .fill(Color.black)
//                            .frame(width: 140, height: 35)
//                            .padding(.top, 15)
                        
                        HStack {
                            // Back Button
                            Button(action: {
                                // Back Action
                            }) {
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                }
                                .foregroundColor(.blue)
                            }
                            .padding(.leading, 20)
                            
                            Spacer()
                        }
                        
                        // Heading
                        Text("Findurant")
                            .font(.custom("Snell Roundhand", size: 36))
                            .foregroundColor(.black)
                            .padding(.top, 20)
                        
                        Spacer()
                        
                        // Bottom Home Indicator
//                        Capsule()
//                            .fill(Color.black)
//                            .frame(width: 140, height: 5)
//                            .padding(.bottom, 15)
                    }
                }
                .frame(height: 750)
                .padding()
                
                Spacer()
            }
        }
    }
}

struct FollowUsView_Previews: PreviewProvider {
    static var previews: some View {
        FollowUsView()
    }
}
