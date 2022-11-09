import Combine
import SwiftUI

final class SignUpLocationStepViewModel: ObservableObject {
    private let name: String
    @Published var typedLocation: String
    @Published var locationsFound: [LocationModel] = []
    @Published var state: LoadableState
    @Injected private var getLocationsUseCase: GetLocationsUseCase
    @Injected private var storeUserUseCase: StoreUserCoreDataUseCase
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(state: LoadableState = .initial,
         name: String,
         typedLocation: String = "") {
        self.state = state
        self.name = name
        self.typedLocation = typedLocation
    }
    
    func search() async {
        DispatchQueue.main.async {
            self.state = .loading
        }
        
        let params = GetLocationsUseCase.Params(text: self.typedLocation)
        await self.getLocationsUseCase.execute(with: params)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case .failure(_) = completion {
                    self?.state = .error
                }
            }, receiveValue: { [weak self] locations in
                self?.state = .loaded
                self?.locationsFound = locations
            })
            .store(in: &subscriptions)
    }
    
    func store(_ location: LocationModel) {
        let user = UserModel(name: self.name, location: location)
        let params = StoreUserCoreDataUseCase.Params(user: user)
        self.storeUserUseCase.execute(with: params)
            .replaceError(with: false)
            .sink(receiveValue: { result in
                print("user has been \(result ? "saved": "not saved")")
            })
            .store(in: &subscriptions)
    }
}

extension SignUpLocationStepViewModel {
    var canSubmit: Bool {
        self.typedLocation.isNotEmpty
    }
}
