//
//  OwnerDashboardView.swift
//  Bhar Pet
//
//  Created by iMac1 on 07/04/26.
//

//import SwiftUI
//import FirebaseAuth
//
//struct OwnerDashboardView: View {
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            
//            Text("Welcome Owner 👑")
//                .font(.largeTitle)
//            
//            Button("Logout") {
//                try? Auth.auth().signOut()
//            }
//        }
//    }
//}


//import SwiftUI
//
//struct OwnerDashboardView: View {
//    
//    @State private var isLoggedOut = false
//    
//    var body: some View {
//        
//        if isLoggedOut {
//            OwnerLoginView()
//        } else {
//            
//            NavigationView {
//                ScrollView {
//                    
//                    VStack(spacing: 20) {
//                        
//                        // MARK: Header
//                        HStack {
//                            VStack(alignment: .leading) {
//                                Text("Dashboard 👑")
//                                    .font(.title)
//                                    .bold()
//                                
//                                Text("Welcome Owner")
//                                    .foregroundColor(.gray)
//                            }
//                            Spacer()
//                        }
//                        
//                        // MARK: Stats
//                        HStack {
//                            StatCard(title: "Users", value: "120")
//                            StatCard(title: "Orders", value: "85")
//                        }
//                        
//                        HStack {
//                            StatCard(title: "Revenue", value: "₹12K")
//                            StatCard(title: "Events", value: "24")
//                        }
//                        
//                        // MARK: Actions
//                        VStack(spacing: 15) {
//                            
//                            DashboardRow(title: "Manage Users", icon: "person.3.fill")
//                            DashboardRow(title: "Manage Orders", icon: "cart.fill")
//                            DashboardRow(title: "Add Event", icon: "plus.circle.fill")
//                            DashboardRow(title: "Analytics", icon: "chart.bar.fill")
//                            DashboardRow(title: "Settings", icon: "gearshape.fill")
//                        }
//                        
//                        // MARK: Logout
//                        Button("Logout") {
//                            isLoggedOut = true
//                        }
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .background(Color.red)
//                        .cornerRadius(10)
//                        
//                    }
//                    .padding()
//                }
//            }
//        }
//    }
//}
//
//
//// MARK: - Components
//
//struct StatCard: View {
//    var title: String
//    var value: String
//    
//    var body: some View {
//        VStack {
//            Text(value)
//                .font(.title)
//                .bold()
//            Text(title)
//                .foregroundColor(.gray)
//        }
//        .frame(maxWidth: .infinity)
//        .padding()
//        .background(Color.blue.opacity(0.1))
//        .cornerRadius(12)
//    }
//}
//
//struct DashboardRow: View {
//    var title: String
//    var icon: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//            Text(title)
//            Spacer()
//        }
//        .padding()
//        .background(Color.gray.opacity(0.1))
//        .cornerRadius(10)
//    }
//}


import SwiftUI

struct OwnerDashboardView: View {
    
    @State private var selectedTab = 0
    let tabs = ["Preparing (5)", "Ready (1)", "Picked (1)"]
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            // MARK: HEADER
            HStack {
                VStack(alignment: .leading) {
                    Text("Outlet Online")
                        .foregroundColor(.green)
                        .font(.caption)
                    
                    Text("Accepting orders")
                        .font(.title2)
                        .bold()
                }
                
                Spacer()
                
                Image(systemName: "bell.fill")
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
            }
            .padding(.horizontal)
            
            
            // MARK: SEARCH
            TextField("Search by order id", text: .constant(""))
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            
            
            // MARK: TABS
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        Text(tabs[index])
                            .padding(.vertical, 8)
                            .padding(.horizontal, 14)
                            .background(selectedTab == index ? Color.red : Color.gray.opacity(0.2))
                            .foregroundColor(selectedTab == index ? .white : .black)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedTab = index
                            }
                    }
                }
                .padding(.horizontal)
            }
            
            
            // MARK: ORDER LIST
            ScrollView {
                VStack(spacing: 15) {
                    
                    OrderCard()
                    OrderCard()
                    
                }
                .padding(.horizontal)
            }
            
            
            // MARK: BOTTOM BAR
            HStack {
                BottomItem(icon: "list.bullet", title: "Menu")
                BottomItem(icon: "chart.bar", title: "Business")
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 60, height: 60)
                    
                    Image(systemName: "bag.fill")
                        .foregroundColor(.black)
                }
                .offset(y: -20)
                
                Spacer()
                
                BottomItem(icon: "megaphone", title: "Campaigns")
                BottomItem(icon: "line.3.horizontal", title: "More")
            }
            .padding()
            .background(Color.white)
        }
        .background(Color(.systemGray6))
    }
}


// MARK: - ORDER CARD

struct OrderCard: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            HStack {
                Text("0224 | 6:30 PM")
                    .font(.headline)
                
                Spacer()
                
                Image(systemName: "ellipsis")
            }
            
            Text("SAMEER'S 10TH ORDER")
                .font(.caption)
                .foregroundColor(.green)
            
            Divider()
            
            HStack {
                Text("1 x Butter Chicken")
                Spacer()
                Text("₹ 410")
            }
            
            HStack {
                Text("1 x Garlic Naan")
                Spacer()
                Text("₹ 90")
            }
            
            Divider()
            
            Text("Total bill: ₹ 500")
                .foregroundColor(.gray)
            
            Button(action: {}) {
                Text("ORDER READY 01:13")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [Color.blue, Color.blue.opacity(0.7)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}


// MARK: - BOTTOM ITEM

struct BottomItem: View {
    
    var icon: String
    var title: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
            Text(title)
                .font(.caption)
        }
    }
}


// MARK: - PREVIEW

#Preview {
    OwnerDashboardView()
}
