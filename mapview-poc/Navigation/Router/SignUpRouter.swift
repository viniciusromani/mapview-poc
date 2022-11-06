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
        case .name: SignUpNameStepView(viewModel: SignUpNameStepViewModel())
        case .location(let username): SignUpLocationStepView(viewModel: SignUpLocationStepViewModel(name: username))
        }
    }
}
