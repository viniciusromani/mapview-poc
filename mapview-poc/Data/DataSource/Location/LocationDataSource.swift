import Combine
import MapKit

protocol LocationDataSource {
    func search(_ text: String) async -> Future<[MKMapItem], Error>
}
