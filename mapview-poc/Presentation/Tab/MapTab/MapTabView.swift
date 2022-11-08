import MapKit
import SwiftUI

struct MapTabView: View {
    @State private var region = MKCoordinateRegion(
        center:
            CLLocationCoordinate2D(
                latitude: 51.5,
                longitude: -0.12
            ),
        span:
            MKCoordinateSpan(
                latitudeDelta: 0.2,
                longitudeDelta: 0.2
            )
    )
    
    var body: some View {
        Map(coordinateRegion: self.$region)
            .navigationBarTitle("MapApp")
    }
}

struct MapTabView_Previews: PreviewProvider {
    static var previews: some View {
        MapTabView()
    }
}
