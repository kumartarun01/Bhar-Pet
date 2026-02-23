//
//  RoseCafeView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

import SwiftUI

struct RoseCafeView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var phone = ""
    @State private var seats = ""
    @State private var selectedDate = Date()
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: selectedDate)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                
                // Restaurant Image
                Image("restaurant2") // Add in Assets
                    .resizable()
                    .scaledToFill()
                    .frame(height: 220)
                    .clipped()
                
                // Title
                Text("Rose Cafe")
                    .font(.title)
                    .bold()
                
                // Description
                Text("Greenery Environment with romantic vibes, food with your choice and pre booking is done by 1 click")
                    .foregroundColor(.gray)
                
                // Reservation Heading
                Text("Reservation Details")
                    .font(.title3)
                    .bold()
                    .padding(.top, 10)
                
                // Name Field
                TextField("Enter Your Name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.08))
                    .cornerRadius(10)
                
                // Phone Field
                TextField("Enter Your Phone Number", text: $phone)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.gray.opacity(0.08))
                    .cornerRadius(10)
                
                // Seats + Date + Time Row
                HStack(spacing: 10) {
                    
                    TextField("Number of seats", text: $seats)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color.gray.opacity(0.08))
                        .cornerRadius(10)
                }
                
                // DatePicker
                DatePicker(
                    "",
                    selection: $selectedDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .labelsHidden()
                
                Spacer(minLength: 40)
                
                // Done Button
                Button(action: {
                    print("Rose Cafe Reservation Confirmed")
                }) {
                    Text("Done")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.3))
                        .foregroundColor(.blue)
                        .cornerRadius(25)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Back")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        RoseCafeView()
    }
}
