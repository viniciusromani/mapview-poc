import MapKit

class LocationModel {
    private(set) var id = UUID()
    private(set) var title: String
    private(set) var latitude: Double
    private(set) var longitude: Double
    
    init() {
        self.title = ""
        self.latitude = 0
        self.longitude = 0
    }
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.placemark.title!
        self.latitude = mapItem.placemark.coordinate.latitude
        self.longitude = mapItem.placemark.coordinate.longitude
    }
    
    init(title: String,
         latitude: Double,
         longitude: Double) {
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init(managed: Location) {
        self.title = managed.title ?? ""
        self.latitude = managed.latitude
        self.longitude = managed.longitude
    }
}

extension LocationModel: Identifiable, Hashable {
    static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        return lhs.title == rhs.title &&
            lhs.latitude == rhs.latitude &&
            lhs.longitude == rhs.longitude
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(self.id)
    }
}
