import SwiftUI

public enum SignUpRouter: NavigationRouter {
    case name
    case location(username: String)
    
    public var transition: NavigationTransitionStyle {
        switch self {
        case .name: return .push
        case .location: return .push
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .name:
            let viewModel = SignUpNameStepViewModel()
            SignUpNameStepView(viewModel: viewModel)
        case .location(let username):
            let viewModel = SignUpLocationStepViewModel(name: username)
            SignUpLocationStepView(viewModel: viewModel)
        }
    }
}
