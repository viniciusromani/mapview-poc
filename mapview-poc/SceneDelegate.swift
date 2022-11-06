import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    private lazy var navigationController: UINavigationController = {
        let navigation = UINavigationController()
        navigation.navigationBar.barTintColor = .blue
        return navigation
    }()
    private lazy var coordinator: Coordinator<SignUpRouter> = .init(navigationController: self.navigationController, startingRoute: .name)
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = self.coordinator.navigationController
        self.window?.makeKeyAndVisible()
        self.coordinator.start()
    }
}
