import MapKit

struct LocationModel {
    private(set) var title: String
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.placemark.title!
    }
}
