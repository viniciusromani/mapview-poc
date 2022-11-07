/**
 This should be refactored to a NavigationView component.
 UINavigationController is still part of UIKit
 */

import UIKit

func customNavigationController() -> UINavigationController {
    let navigation = UINavigationController()
    let backButtonImage = UIImage(named: "ArrowLeft")
    navigation.navigationBar.backIndicatorImage = backButtonImage
    navigation.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 105/255, green: 56/255, blue: 219/255, alpha: 1)]
    return navigation
}
