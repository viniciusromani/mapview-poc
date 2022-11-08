import Combine
import MapKit

/**
TODO: Error treatment must be implemented
*/
class LocalLocationDataSource: LocationDataSource {
    func search(_ text: String) async -> Future<[MKMapItem], Error> {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = text
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = .address
        let search = MKLocalSearch(request: request)
        return Future {
            let results = try await search.start()
            return results.mapItems
        }
    }
}
