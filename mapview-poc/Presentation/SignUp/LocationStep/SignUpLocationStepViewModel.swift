import Combine
import SwiftUI

final class SignUpLocationStepViewModel: ObservableObject {
    private let name: String
    @Published var typedLocation: String
    @Published var locationsFound: [String] = []
    @Published var state: LoadableState
    @Injected private var getLocationsUseCase: GetLocationsUseCase
    @Injected private var storeUserUseCase: StoreUserCoreDataUseCase
    
    private(set) var subscriptions = Set<AnyCancellable>()
    
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
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] locations in
                self?.state = .loaded
                self?.locationsFound = locations.map { $0.title }
                
                let location = locations.first!
                let user = UserModel(name: self!.name, location: location)
                let params = StoreUserCoreDataUseCase.Params(user: user)
                self?.storeUserUseCase.execute(with: params).sink(receiveCompletion: { _ in }, receiveValue: { _ in }).store(in: &self!.subscriptions)
            })
            .store(in: &subscriptions)
    }
}

extension SignUpLocationStepViewModel {
    var canSubmit: Bool {
        self.typedLocation.isNotEmpty
    }
}
