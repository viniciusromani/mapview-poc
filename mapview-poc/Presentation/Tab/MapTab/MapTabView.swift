import MapKit
import SwiftUI

struct MapTabView: View {
    @StateObject
    private var viewModel = MapTabViewModel()
    
    var body: some View {
        Map(coordinateRegion: self.$viewModel.region,
            annotationItems: [viewModel.storedLocation]) { place in
            MapMarker(
                coordinate: CLLocationCoordinate2D(
                    latitude: place.latitude,
                    longitude: place.longitude
                ),
                tint: .accentColor
            )
        }
        .onAppear { self.viewModel.getUserLocation() }
    }
}

struct MapTabView_Previews: PreviewProvider {
    static var previews: some View {
        MapTabView()
    }
}
