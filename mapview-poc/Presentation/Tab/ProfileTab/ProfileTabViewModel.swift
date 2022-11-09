import Combine
import SwiftUI

struct UserSceneModel {
    private(set) var name: String
    private(set) var location: String
    
    init() {
        self.name = ""
        self.location = ""
    }
    
    init(model: UserModel) {
        self.name = model.name
        self.location = model.location.title
    }
}

final class ProfileTabViewModel: ObservableObject {
    @Published var user: UserSceneModel? = UserSceneModel()
    
    @Injected private var getUserUseCase: GetUserCoreDataUseCase
    
    private var subscriptions = Set<AnyCancellable>()
    
    func getUser() {
        self.getUserUseCase.execute()
            .receive(on: RunLoop.main)
            .replaceError(with: nil)
            .sink(receiveCompletion: { _ in }) { [weak self] user in
                guard let user = user else { return }
                self?.user = UserSceneModel(model: user)
            }
            .store(in: &subscriptions)
    }
}
