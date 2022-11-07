import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    private lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController()
        let backButtonImage = UIImage(named: "ArrowLeft")
        navigation.navigationBar.backIndicatorImage = backButtonImage
        navigation.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 105/255, green: 56/255, blue: 219/255, alpha: 1)]
        return navigation
    }()
    private lazy var coordinator: Coordinator<SignUpRouter> = .init(navigationController: self.navigationController, startingRoute: .name)
    
    var window: UIWindow?
    
    private func injectDependencies() {
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
