import Combine
import MapKit
import SwiftUI

final class MapTabViewModel: ObservableObject {
    @Published var storedLocation: LocationModel = LocationModel()
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    
    @Injected private var getUserUseCase: GetUserCoreDataUseCase
    
    private(set) var subscriptions = Set<AnyCancellable>()
    
    func getUserLocation() {
        self.getUserUseCase.execute()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in }) { [weak self] user in
                guard let user = user else { return }
                self?.storedLocation = user.location
                self?.region = MKCoordinateRegion(
                    center:
                        CLLocationCoordinate2D(
                            latitude: user.location.latitude,
                            longitude: user.location.longitude
                        ),
                    span:
                        MKCoordinateSpan(
                            latitudeDelta: 0.2,
                            longitudeDelta: 0.2
                    ))
            }
            .store(in: &subscriptions)
    }
}
