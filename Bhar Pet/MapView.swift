import SwiftUI
import MapKit
import CoreLocation
import Combine

// MARK: - Location Manager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let manager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
}

// MARK: - Model
struct PlaceItem: Identifiable {
    let id = UUID()
    let mapItem: MKMapItem
}

// MARK: - Main View
struct MapView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ))
    
    @State private var searchText = ""
    @State private var places: [PlaceItem] = []
    @State private var selectedPlace: MKMapItem?
    
    @State private var route: MKRoute?
    
    var body: some View {
        ZStack {
            
            Map(position: $cameraPosition) {
                ForEach(places) { item in
                    let coord = item.mapItem.placemark.coordinate
                    Annotation(item.mapItem.name ?? "Place", coordinate: coord) {
                        Button {
                            selectedPlace = item.mapItem
                            getDirections(to: item.mapItem)
                        } label: {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                    }
                }
                if let route = route {
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 5)
                }
            }
            .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    TextField("Search nearby places...", text: $searchText)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button("Search") {
                        searchPlaces()
                    }
                }
                .padding()
                
                Spacer()
                
                if let place = selectedPlace {
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text(place.name ?? "Place")
                            .font(.headline)
                        
                        if let route = route {
                            Text("ETA: \(Int(route.expectedTravelTime / 60)) min")
                            Text("Distance: \(String(format: "%.2f", route.distance / 1000)) km")
                        } else if let distance = calculateDistance(to: place) {
                            Text("Distance: \(distance) km")
                        }
                        
                        Button("Navigate in Maps") {
                            openInMaps(place)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(15)
                    .padding()
                }
            }
        }
        
        .onChange(of: locationManager.userLocation) { _, newLocation in
            if let loc = newLocation {
                region.center = loc.coordinate
                cameraPosition = .region(MKCoordinateRegion(center: loc.coordinate, span: region.span))
            }
        }
    }
    
    // MARK: - Search
    func searchPlaces() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region
        
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            if let items = response?.mapItems {
                places = items.map { PlaceItem(mapItem: $0) }
            }
        }
    }
    
    // MARK: - Distance
    func calculateDistance(to place: MKMapItem) -> String? {
        guard let userLoc = locationManager.userLocation else { return nil }
        
        let placeLoc = CLLocation(
            latitude: place.placemark.coordinate.latitude,
            longitude: place.placemark.coordinate.longitude
        )
        
        let distance = userLoc.distance(from: placeLoc) / 1000
        return String(format: "%.2f", distance)
    }
    
    // MARK: - Directions
    func getDirections(to place: MKMapItem) {
        guard let userLoc = locationManager.userLocation else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(
            placemark: MKPlacemark(coordinate: userLoc.coordinate)
        )
        request.destination = place
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let route = response?.routes.first {
                self.route = route
                let newRegion = MKCoordinateRegion(route.polyline.boundingMapRect)
                region = newRegion
                cameraPosition = .region(newRegion)
            }
        }
    }
    
    // MARK: - Open Maps
    func openInMaps(_ place: MKMapItem) {
        place.openInMaps(launchOptions: [
            MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
        ])
    }
}

// MARK: - Preview
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
