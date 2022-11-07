import SwiftUI

open class Coordinator<Router: NavigationRouter>: ObservableObject {
    public let navigationController: UINavigationController
    public let startingRoute: Router?
    public var childrenCoordinators: [Coordinator] = []

    public init(navigationController: UINavigationController = .init(), startingRoute: Router? = nil) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
    }

    public func start() {
        guard let route = startingRoute else { return }
        self.show(route)
    }

    public func startChild(_ child: Coordinator) {
        self.childrenCoordinators.append(child)
        child.start()
    }

    public func finishChild(_ child: Coordinator) {
        for (index, coordinator) in self.childrenCoordinators.enumerated() {
            if coordinator === child {
                self.childrenCoordinators.remove(at: index)
                break
            }
        }
    }

    public func show(_ route: Router, animated: Bool = true) {
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
        case .push:
            self.navigationController.pushViewController(viewController, animated: animated)
        case .present:
            viewController.modalPresentationStyle = .fullScreen
            self.navigationController.present(viewController, animated: animated)
        case .flipRoot:
            self.navigationController.pushViewController(viewController, animated: animated)
        }
    }

    public func pop(animated: Bool = true) {
        self.navigationController.popViewController(animated: animated)
    }

    open func dismiss(animated: Bool = true) {
        self.navigationController.dismiss(animated: true) { [weak self] in
            /// because there is a leak in UIHostingControllers that prevents from deallocation
            self?.navigationController.viewControllers = []
        }
    }
}
