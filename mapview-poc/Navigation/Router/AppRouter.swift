import SwiftUI

public enum AppRouter: NavigationRouter {
    case signUp
    case home
    
    public var transition: NavigationTransitionStyle {
        switch self {
        case .signUp: return .push
        case .home: return .flipRoot
        }
    }
    
    public func view() -> some View {
//        switch self {
//        case .signUp: SignUpNameStepView(viewModel: SignUpNameStepViewModel())
//        case .home: SignUpLocationStepView(viewModel: SignUpLocationStepViewModel(name: username))
//        }
        return SignUpNameStepView(viewModel: SignUpNameStepViewModel())
    }
}
