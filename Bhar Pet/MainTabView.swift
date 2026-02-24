//
//  MainTabView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//
import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var auth: AuthViewModel
    
    var body: some View {
        Group {
            if auth.isAuthenticated {
                NavigationStack {
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
                        
                        ReservationView()
                            .tabItem {
                                Image(systemName: "fork.knife.circle.fill")
                                Text("Reservation")
                            }
                        
                        SettingsView()
                            .tabItem {
                                Image(systemName: "gear")
                                Text("Settings")
                            }
                    }
                }.toolbar(.hidden)
            } else {
                AuthView(auth: auth)
            }
        }
    }
}

//struct MainTabView: View {
////    @StateObject private var auth = AuthViewModel()
//    @EnvironmentObject var auth: AuthViewModel
//    var body: some View {
//         Group {
//            if auth.isAuthenticated {
//                NavigationStack {
//                    TabView {
//                        
//                        HomeView()
//                            .tabItem {
//                                Image(systemName: "house")
//                                Text("Home")
//                            }
//                        
//                        BookingView()
//                            .tabItem {
//                                Image(systemName: "calendar")
//                                Text("Booking")
//                            }
//                        
//                        MapView()
//                            .tabItem {
//                                Image(systemName: "map")
//                                Text("Map")
//                            }
//                        
//                        ReservationView()
//                            .tabItem {
//                                Image(systemName: "fork.knife.circle.fill")
//                                Text("Reservation")
//                            }
//                        
//                        SettingsView()
//                            .tabItem {
//                                Image(systemName: "gear")
//                                Text("Settings")
//                            }
//                        
//                    }
//                }.toolbar(.hidden)
//
//            } else {
//                AuthView(auth: auth)
//            }
//         }
//    }
//}
//#Preview {
//    MainTabView()
//}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(AuthViewModel())
            .environmentObject(CartManager())
    }
}
