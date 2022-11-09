import MapKit
import SwiftUI

struct MapTabView: View {
    @StateObject
    private var viewModel = MapTabViewModel()
    
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
        .alert(isPresented: Binding(get: {
            viewModel.storedLocation == nil
        }, set: { _ in })) {
            Alert(
                title: Text("No user was found"),
                message: Text("Please reinstall the app and fill up the onboarding"),
                dismissButton: .default(Text("Got it!")))
        }
    }
}

struct MapTabView_Previews: PreviewProvider {
    static var previews: some View {
        MapTabView()
    }
}
