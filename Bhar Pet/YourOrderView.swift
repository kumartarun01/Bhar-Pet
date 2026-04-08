//import SwiftUI

//
//  YourOrderView.swift
//  Bhar Pet
//
//  Created by iMac1 on 12/02/26.
//


    import SwiftUI
    import Combine
    import MapKit

    // MARK: - MODEL
    struct TrackingPlace: Identifiable {
        let id = UUID()
        let coordinate: CLLocationCoordinate2D
        let type: String
    }

    // MARK: - VIEWMODEL (Simulated Live Movement)
    class LiveLocationManager: ObservableObject {
        @Published var driverLocation = CLLocationCoordinate2D(
            latitude: 28.6139,   // Start (example: Delhi)
            longitude: 77.2090
        )
        
        let destination = CLLocationCoordinate2D(
            latitude: 28.6200,   // Destination
            longitude: 77.2300
        )
        
        var timer: Timer?
        
        init() {
            startMoving()
        }
        
        func startMoving() {
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { _ in
                DispatchQueue.main.async {
                    // Smooth movement toward destination
                    let latDiff = self.destination.latitude - self.driverLocation.latitude
                    let longDiff = self.destination.longitude - self.driverLocation.longitude
                    
                    self.driverLocation.latitude += latDiff * 0.05
                    self.driverLocation.longitude += longDiff * 0.05
                }
            }
        }
    }

    // MARK: - MAIN VIEW
    struct LiveTrackingMapView: View {
        
        @StateObject var locationManager = LiveLocationManager()
        
        @State private var region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090),
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
        
        var body: some View {
            ZStack {
                
                Map(coordinateRegion: $region,
                    annotationItems: getAnnotations()) { place in
                    
                    MapAnnotation(coordinate: place.coordinate) {
                        VStack {
                            Image(systemName: place.type == "driver" ? "person.fill" : "house.fill")
                                .font(.title)
                                .foregroundColor(place.type == "order" ? .blue : .red)
                            
                            Text(place.type.capitalized)
                                .font(.caption)
                                .padding(4)
                                .background(Color.white)
                                .cornerRadius(6)
                        }
                    }
                }
                .onReceive(locationManager.$driverLocation) { newLocation in
                    withAnimation {
                        region.center = newLocation
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                
                // INFO CARD UI
                VStack {
                    Spacer()
                    
                    VStack(spacing: 10) {
                        Text("🚚 Order is on the way")
                            .font(.headline)
                        
                        Text("Driver is moving to your location")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .padding()
                }
            }
        }
        
        // MARK: - Annotations
        func getAnnotations() -> [TrackingPlace] {
            [
                TrackingPlace(
                    coordinate: locationManager.driverLocation,
                    type: "driver"
                ),
                TrackingPlace(
                    coordinate: locationManager.destination,
                    type: "destination"
                )
            ]
        }
    }

    // MARK: - ENTRY VIEW (Test)
    struct YourOrderView: View {
             @ObservedObject var manager = CartManager2.shared
        var body: some View {
            NavigationView {
                    List {
                                ForEach(manager.orders) { order in
                                    VStack(alignment: .leading) {
                                        Text("Order Total: ₹\(order.total)")
                                            .bold()
                
                                        ForEach(order.items) { item in
                                            Text("\(item.food.name) x \(item.quantity)")
                                        }
                                    }
                                    NavigationLink("Track Order 🚗") {
                                        LiveTrackingMapView()
                                    }
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                }
                      
                            }
                        
                    
                    
                 
                }
            }
        }
#Preview {
    NavigationStack {
        YourOrderView()
    }
}

