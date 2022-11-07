import Combine
import SwiftUI

final class SignUpLocationStepViewModel: ObservableObject {
    private let name: String
    @Published
    var typedLocation: String
    @Published
    var locationsFound: [String]
    @Injected
    private var getLocationsUseCase: GetLocationsUseCase
    
    private(set) var subscriptions = Set<AnyCancellable>()
    
    init(name: String,
         typedLocation: String = "") {
        self.name = name
        self.typedLocation = typedLocation
        self.locationsFound = []
    }
    
    func search() async {
        let params = GetLocationsUseCase.Params(text: self.typedLocation)
        await self.getLocationsUseCase.execute(with: params)
            .sink(receiveCompletion: { _ in }, receiveValue: { locations in
                self.locationsFound = locations.map { $0.title }
            })
            .store(in: &subscriptions)
    }
}

extension SignUpLocationStepViewModel {
    var canSubmit: Bool {
        self.typedLocation.isNotEmpty
    }
}
