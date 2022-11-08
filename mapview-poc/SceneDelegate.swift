import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    private lazy var navigationController: UINavigationController = {
        return customNavigationController()
    }()
    private lazy var coordinator = AppCoordinator(window: self.window,
                                                  navigationController: self.navigationController)
    
    var window: UIWindow?
    
    private func injectDependencies() {
        _ = DataInjector()
        _ = DomainInjector()
        _ = PresentationInjector()
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.injectDependencies()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = self.coordinator.navigationController
        self.window?.makeKeyAndVisible()
        self.coordinator.start()
    }
}
