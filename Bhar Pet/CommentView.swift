//
//  CommentView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct CommentView: View {
    
    @State private var commentText: String = ""
    
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .ignoresSafeArea()
            
            VStack {
                ZStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        
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
                        .padding(.leading)
                        .padding(.top, 10)
                        
                        // Heading
                        Text("Feedback")
                            .font(.custom("Snell Roundhand", size: 36))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                        
                        Spacer()
                        
                        // Comment Box
                        ZStack {
                            
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.gray.opacity(0.7), lineWidth: 1.5)
                                .frame(height: 180)
                            
                            if commentText.isEmpty {
                                Text("Leave your comment")
                                    .foregroundColor(.gray.opacity(0.6))
                            }
                            
                            TextEditor(text: $commentText)
                                .padding(8)
                                .frame(height: 180)
                                .background(Color.clear)
                        }
                        .padding(.horizontal, 40)
                        
                        Spacer()
                        
                        // Done Button
                        Button(action: {
                            print("Feedback Submitted")
                        }) {
                            Text("Done")
                                .foregroundColor(.blue)
                                .font(.system(size: 18, weight: .medium))
                        }
                        .frame(maxWidth: .infinity)
                        
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

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        CommentView()
    }
}
