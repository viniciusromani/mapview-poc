import Combine
import SwiftUI

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    weak var window: UIWindow?
    
    init(window: UIWindow?,
         navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        let child = SplashCoordinator(parentCoordinator: self,
                                      navigationController: navigationController)
        self.startChild(child)
    }
    
    func didFinishSplash(user: UserModel?) {
        self.navigationController = customNavigationController()
        let child: Coordinator =
            user == nil ?
                SignUpCoordinator(parentCoordinator: self,
                                  navigationController: self.navigationController):
                TabCoordinator(parentCoordinator: self,
                               navigationController: self.navigationController)
        self.startChild(child)
        self.window?.rootViewController = self.navigationController
    }
    
    func didFinishSignUp() {
        UIView.transition(with: window!, duration: 0.5, options: [.transitionFlipFromLeft]) {
            self.navigationController = customNavigationController()
            
            let child = TabCoordinator(parentCoordinator: self,
                                       navigationController: self.navigationController)
            self.startChild(child)
            self.window?.rootViewController = self.navigationController
        }
    }
    
    func didLogout() {
        UIView.transition(with: self.window!, duration: 0.5, options: [.transitionFlipFromLeft]) {
            self.navigationController = customNavigationController()
            
            let child = SignUpCoordinator(parentCoordinator: self,
                                          navigationController: self.navigationController)
            self.startChild(child)
            self.window?.rootViewController = self.navigationController
        }
    }
}
