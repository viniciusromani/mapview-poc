import Combine
import SwiftUI

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    weak var window: UIWindow?
    
    @Injected private var getUserUseCase: GetUserCoreDataUseCase
    private var subscriptions = Set<AnyCancellable>()
    
    init(window: UIWindow?,
         navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        self.getUserUseCase.execute()
            .receive(on: RunLoop.main)
            .replaceError(with: nil)
            .sink(receiveValue: { user in
                let child: Coordinator =
                    user == nil ?
                        SignUpCoordinator(parentCoordinator: self,
                                          navigationController: self.navigationController):
                        TabCoordinator(parentCoordinator: self,
                                       navigationController: self.navigationController)
                self.startChild(child)
            })
            .store(in: &subscriptions)
    }
    
    func didFinishSignUp() {
        UIView.transition(with: self.window!, duration: 0.5, options: [.transitionFlipFromLeft]) {
            self.navigationController = customNavigationController()
            
            let child = TabCoordinator(parentCoordinator: self,
                                       navigationController: self.navigationController)
            self.startChild(child)
            self.window?.rootViewController = self.navigationController
        }
    }
    
    func didLogOut() {
        UIView.transition(with: self.window!, duration: 0.5, options: [.transitionFlipFromLeft]) {
            self.navigationController = customNavigationController()
            
            let child = SignUpCoordinator(parentCoordinator: self,
                                          navigationController: self.navigationController)
            self.startChild(child)
            self.window?.rootViewController = self.navigationController
        }
    }
}
