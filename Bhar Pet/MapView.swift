//
//  MapView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//
import SwiftUI
import MapKit


struct MapView: View {
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                Map(position: $cameraPosition) {
                    // No MapContent for now; plain map view
                }
                .ignoresSafeArea()
                
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: .constant(""))
                    Spacer()
                    Image(systemName: "paperplane.fill")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(15)
                .padding()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    MapView()
}


//import SwiftUI
//import MapKit
//import CoreLocation
//import Combine   // ✅ FIX ADDED
//
//// 📍 LOCATION MANAGER
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    
//    private let manager = CLLocationManager()
//    @Published var location: CLLocation?
//    
//    override init() {
//        super.init()
//        manager.delegate = self
//        manager.requestWhenInUseAuthorization()
//        manager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        location = locations.first
//    }
//}
//
//struct MapKitGoogleStyleView: View {
//    
//    @StateObject private var locationManager = LocationManager()
//    
//    @State private var cameraPosition: MapCameraPosition = .automatic
//    @State private var searchText = ""
//    @State private var results: [MKMapItem] = []
//    @State private var selectedPlace: MKMapItem?
//    @State private var route: MKRoute?
//    
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: .top) {
//                
//                Map(position: $cameraPosition, selection: $selectedPlace) {
//                    
//                    UserAnnotation()
//                    
//                    ForEach(results, id: \.self) { item in
//                        Marker(item.name ?? "Place", coordinate: item.placemark.coordinate)
//                    }
//                    
//                    if let route {
//                        MapPolyline(route.polyline)
//                            .stroke(.blue, lineWidth: 6)
//                    }
//                }
//                .ignoresSafeArea()
//                .onChange(of: selectedPlace) {
//                    if let place = selectedPlace {
//                        fetchRoute(to: place)
//                    }
//                }
//                
//                // 🔍 SEARCH BAR
//                HStack {
//                    Image(systemName: "magnifyingglass")
//                    
//                    TextField("Search restaurants...", text: $searchText)
//                        .onSubmit { searchPlaces() }
//                    
//                    Spacer()
//                    
//                    Button {
//                        searchPlaces()
//                    } label: {
//                        Image(systemName: "paperplane.fill")
//                    }
//                }
//                .padding()
//                .background(.white)
//                .cornerRadius(15)
//                .padding()
//                
//                // 📦 BOTTOM PANEL
//                VStack {
//                    Spacer()
//                    
//                    if let selectedPlace {
//                        VStack(spacing: 10) {
//                            
//                            Text(selectedPlace.name ?? "")
//                                .font(.headline)
//                            
//                            if let distance = calculateDistance(to: selectedPlace) {
//                                Text("Distance: \(distance)")
//                            }
//                            
//                            if let route {
//                                Text("ETA: \(formatTime(route.expectedTravelTime))")
//                            }
//                            
//                            HStack {
//                                Button("Route") {
//                                    fetchRoute(to: selectedPlace)
//                                }
//                                .padding()
//                                .background(.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                                
//                                Button("Navigate") {
//                                    openInMaps(selectedPlace)
//                                }
//                                .padding()
//                                .background(.green)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                            }
//                        }
//                        .padding()
//                        .background(.white)
//                        .cornerRadius(15)
//                        .shadow(radius: 5)
//                        .padding()
//                    }
//                }
//            }
//        }
//    }
//    
//    // 🔍 SEARCH
//    func searchPlaces() {
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = searchText.isEmpty ? "Restaurants" : searchText
//        
//        if let location = locationManager.location {
//            request.region = MKCoordinateRegion(
//                center: location.coordinate,
//                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
//            )
//        }
//        
//        MKLocalSearch(request: request).start { response, _ in
//            results = response?.mapItems ?? []
//        }
//    }
//    
//    // 🚗 ROUTE
//    func fetchRoute(to destination: MKMapItem) {
//        guard let userLocation = locationManager.location else { return }
//        
//        let request = MKDirections.Request()
//        request.source = MKMapItem(
//            placemark: MKPlacemark(coordinate: userLocation.coordinate)
//        )
//        request.destination = destination
//        request.transportType = .automobile
//        
//        MKDirections(request: request).calculate { response, _ in
//            if let route = response?.routes.first {
//                self.route = route
//                cameraPosition = .rect(route.polyline.boundingMapRect)
//            }
//        }
//    }
//    
//    // 📏 DISTANCE
//    func calculateDistance(to item: MKMapItem) -> String? {
//        guard let userLocation = locationManager.location else { return nil }
//        
//        let place = CLLocation(
//            latitude: item.placemark.coordinate.latitude,
//            longitude: item.placemark.coordinate.longitude
//        )
//        
//        let km = userLocation.distance(from: place) / 1000
//        return String(format: "%.2f km", km)
//    }
//    
//    // ⏱ TIME
//    func formatTime(_ seconds: TimeInterval) -> String {
//        "\(Int(seconds / 60)) mins"
//    }
//    
//    // 🧭 NAVIGATION
//    func openInMaps(_ place: MKMapItem) {
//        place.openInMaps(launchOptions: [
//            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
//        ])
//    }
//}
//
//#Preview {
//    MapKitGoogleStyleView()
//}
