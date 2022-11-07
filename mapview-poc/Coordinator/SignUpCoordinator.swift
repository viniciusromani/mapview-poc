import SwiftUI

class SignUpCoordinator: Coordinator, ObservableObject {
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
        let viewModel = SignUpNameStepViewModel()
        let view = SignUpNameStepView(viewModel: viewModel)
        let viewWithCoordinator = view.environmentObject(self)
        let hosting = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(hosting, animated: false)
    }
    
    func didFinishName(_ name: String) {
        let viewModel = SignUpLocationStepViewModel(name: name)
        let view = SignUpLocationStepView(viewModel: viewModel)
        let viewWithCoordinator = view.environmentObject(self)
        let hosting = UIHostingController(rootView: viewWithCoordinator)
        self.navigationController.pushViewController(hosting, animated: true)
    }
    
    func didFinishSignUp() {
        guard let appCoordinator = self.parentCoordinator as? AppCoordinator else {
            fatalError("Parent Coordinator must be AppCoordinator")
        }
        appCoordinator.childDidFinish(self)
        appCoordinator.didFinishSignUp()
    }
}
