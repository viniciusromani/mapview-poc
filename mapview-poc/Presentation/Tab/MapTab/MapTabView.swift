import MapKit
import SwiftUI

struct MapTabView: View {
    @StateObject
    var viewModel = MapTabViewModel()
    
    var body: some View {
        ZStack {
            if let location = viewModel.storedLocation {
                Map(coordinateRegion: $viewModel.region,
                    annotationItems: [location]) { place in
                    MapMarker(
                        coordinate: CLLocationCoordinate2D(
                            latitude: place.latitude,
                            longitude: place.longitude
                        ),
                        tint: .accentColor
                    )
                }
            }
        }
        .onAppear { viewModel.getUserLocation() }
        .alert(isPresented: Binding(viewModel.storedLocation == nil)) {
            Alert(
                title: Text("No user was found"),
                message: Text("Please reinstall the app and fill up the onboarding"),
                dismissButton: .default(Text("Got it!")))
        }
    }
}

struct MapTabView_Previews: PreviewProvider {
    static let location: MapTabViewModel = {
        let _location = MapTabViewModel()
        let model = LocationModel(
            title: "Piracicaba - SP, Brazil",
            latitude: -22.7292941,
            longitude: -47.6496458
        )
        _location.storedLocation = model
        _location.region = MKCoordinateRegion(
            center:
                CLLocationCoordinate2D(
                    latitude: model.latitude,
                    longitude: model.longitude
                ),
            span:
                MKCoordinateSpan(
                    latitudeDelta: 0.2,
                    longitudeDelta: 0.2
            ))
        return _location
    }()
    static let noUser: MapTabViewModel = {
        let _noUser = MapTabViewModel()
        _noUser.storedLocation = nil
        return _noUser
    }()
    
    static var previews: some View {
        let _ = DataInjector()
        let _ = DomainInjector()
        
        MapTabView()
            .previewDisplayName("No Location")
        
        MapTabView(viewModel: location)
            .previewDisplayName("Location Found")
        
        MapTabView(viewModel: noUser)
            .previewDisplayName("No User")
    }
}
