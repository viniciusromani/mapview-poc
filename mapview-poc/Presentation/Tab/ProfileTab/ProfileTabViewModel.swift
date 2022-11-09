import Combine
import SwiftUI

final class ProfileTabViewModel: ObservableObject {
    @Published var user: UserModel? = UserModel()
    
    @Injected private var getUserUseCase: GetUserCoreDataUseCase
    @Injected private var deleteUserUseCase: DeleteUserCoreDataUseCase
    
    private var subscriptions = Set<AnyCancellable>()
    
    func getUser() {
        self.getUserUseCase.execute()
            .receive(on: RunLoop.main)
            .replaceError(with: nil)
            .sink(receiveCompletion: { _ in }) { [weak self] user in
                guard let user = user else { return }
                self?.user = user
            }
            .store(in: &subscriptions)
    }
    
    func logout() {
        guard let user = self.user else { return }
        let params = DeleteUserCoreDataUseCase.Params(user: user)
        self.deleteUserUseCase.execute(with: params)
            .replaceError(with: false)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }
}
