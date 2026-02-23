//
//  BookingView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//
import SwiftUI

struct ReservationView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Reservation")
                    .font(.custom("Snell Roundhand", size: 40))
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: -1, trailing: 0))
                ScrollView {
                    VStack(alignment: .center, spacing: 5) {
                        
                        NavigationLink {
                            ForagedFareView()
                        }label: {
                            RestaurantCard(
                                image: "restaurant1",
                                title: "Foraged Fare",
                                description: "Peaceful Environment, Fresh Food, Indian, Spanish, Italian food available..."
                            )
                        }.foregroundStyle(.primary)
                        
                        NavigationLink {
                            RoseCafeView()
                        }label: {
                            RestaurantCard(
                                image: "restaurant2",
                                title: "Rose Cafe",
                                description: "Greenery environment with romantic vibes. Pre-booking available..."
                            )
                        }.foregroundStyle(.primary)
                        
                        NavigationLink {
                            OliveBarView()
                        }label: {
                            RestaurantCard(
                                image: "restaurant3",
                                title: "Olive Bar & Kitchen",
                                description: "Perfect place for candle light dinner and family gatherings..."
                            )
                        }.foregroundStyle(.primary)
                    }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)

            }.ignoresSafeArea()
        }
            }
}

struct RestaurantCard: View {
    var image: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(image)
                .resizable()
//                .scaledToFill()
                .frame(height: 180)
                .clipped()
                .cornerRadius(5)
//                .padding(10)
            
            Text(title)
                .font(.title2)
                .bold()
//                .padding(.leading, 10)
            
            Text(description)
                .font(.footnote)
                .foregroundColor(.gray)
//               .padding(.leading, 10)
        }
        
    }
}
#Preview {
    ReservationView()
}

