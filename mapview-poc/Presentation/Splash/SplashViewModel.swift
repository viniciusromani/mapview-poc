import Combine
import MapKit
import SwiftUI

final class SplashViewModel: ObservableObject {
    @Injected private var getUserUseCase: GetUserCoreDataUseCase
    
    private var subscriptions = Set<AnyCancellable>()
    
    func getUser() async -> UserModel? {
        do {
            let user = try await self.getUserUseCase.execute().async()
            return user
        } catch {
            return nil
        }
    }
}
