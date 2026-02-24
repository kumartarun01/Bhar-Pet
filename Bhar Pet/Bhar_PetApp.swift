//
//  Bhar_PetApp.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//

//import SwiftUI
//
////@main
////struct Bhar_PetApp: App {
////    var body: some Scene {
////        WindowGroup {
////            ContentView()
////        }
////    }
////}
//
//@main
//struct BharPetApp: App {
//    
//    @StateObject var cartManager = CartManager()
//    
//    var body: some Scene {
//        WindowGroup {
//            NavigationStack {
//                ContentView()
//            }
//            .environmentObject(cartManager)
//        }
//    }
//}

import SwiftUI
//import CoreData
import FirebaseCore

@main
struct Bhar_PetApp: App {
    @StateObject var cartManager = CartManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(cartManager)
        }
    }
}
