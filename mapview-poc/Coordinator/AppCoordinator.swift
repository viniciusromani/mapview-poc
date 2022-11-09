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
        let child = SignUpCoordinator(parentCoordinator: self,
                                      navigationController: self.navigationController)
        self.startChild(child)
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
