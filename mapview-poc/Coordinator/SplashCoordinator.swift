import SwiftUI

class SplashCoordinator: Coordinator, ObservableObject {
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    private let parentCoordinator: Coordinator
    
    init(parentCoordinator: Coordinator,
         navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        let view = SplashView()
        let viewWithCoordinator = view.environmentObject(self)
        let hosting = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(hosting, animated: false)
    }
    
    func didFinishSplash(user: UserModel?) {
        guard let appCoordinator = self.parentCoordinator as? AppCoordinator else {
            fatalError("Parent Coordinator must be AppCoordinator")
        }
        appCoordinator.childDidFinish(self)
        appCoordinator.didFinishSplash(user: user)
    }
}
