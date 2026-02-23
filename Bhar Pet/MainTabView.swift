//
//  MainTabView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            BookingView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Booking")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}
#Preview {
    MainTabView()
}
