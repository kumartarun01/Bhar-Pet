//
//  ContentView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            // MARK: - Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.95, green: 0.90, blue: 0.92),
                    Color(red: 0.88, green: 0.90, blue: 0.96),
                    Color(red: 0.92, green: 0.85, blue: 0.95)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 25) {
                
                Spacer()
                
                // MARK: - App Title
                Text("FINDURANT")
                    .font(.system(size: 40, weight: .regular, design: .serif))
                    .italic()
                    .foregroundColor(.black)
                
                // MARK: - Subtitle
                Text("Restaurant which you know well!!!")
                    .font(.system(size: 18, weight: .light))
                    .foregroundColor(.gray)
                
                Spacer()
                
                // MARK: - Food Image
                Image("food_icon") // Add your image in Assets
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer()
                
                // MARK: - Get Start Button
                Button(action: {
                    print("Get Start tapped")
                }) {
                    Text("Get Start")
                        .font(.system(size: 36))
                        .italic()
                        .foregroundColor(.blue)
                }
                
                // MARK: - Sign Up
                Button(action: {
                    print("Sign up tapped")
                }) {
                    Text("Sign up")
                        .font(.system(size: 18))
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

