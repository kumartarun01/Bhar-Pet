//
//  HelpView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct HelpView: View {
    
    @State private var problemText: String = ""
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                
                // Top VC Label
//                Text("HelpVC")
//                    .font(.headline)
//                    .padding(.top, 10)
                
                Spacer()
                
                // iPhone Style Container
                ZStack(alignment: .top) {
                    
//                    RoundedRectangle(cornerRadius: 45)
//                        .fill(Color(.systemGray5))
                    
                    VStack(alignment: .leading) {
                        
                        // Dynamic Island
//                        Capsule()
//                            .fill(Color.black)
//                            .frame(width: 140, height: 35)
//                            .padding(.top, 15)
//                            .frame(maxWidth: .infinity)
                        
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
                        Text("Help & Support")
                            .font(.custom("Snell Roundhand", size: 34))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                        
                        Spacer()
                        
                        // Text Area
                        ZStack(alignment: .center) {
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.7), lineWidth: 1.5)
                                .frame(height: 180)
                            
                            if problemText.isEmpty {
                                Text("Type your Problem")
                                    .foregroundColor(.gray.opacity(0.6))
                            }
                            
                            TextEditor(text: $problemText)
                                .padding(8)
                                .frame(height: 180)
                                .background(Color.clear)
                        }
                        .padding(.horizontal, 40)
                        
                        Spacer()
                        
                        // Report Button
                        Button(action: {
                            print("Problem Reported")
                        }) {
                            Text("Report")
                                .foregroundColor(.blue)
                                .font(.system(size: 18, weight: .medium))
                        }
                        .frame(maxWidth: .infinity)
                        
                        Spacer()
                        
                        // Bottom Home Indicator
//                        Capsule()
//                            .fill(Color.black)
//                            .frame(width: 140, height: 5)
//                            .padding(.bottom, 15)
//                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .frame(height: 750)
                
                Spacer()
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
