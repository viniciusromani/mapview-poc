import SwiftUI

public enum SignUpRouter: NavigationRouter {
    case name
    case location
    
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
        case .location: SignUpNameStepView(viewModel: SignUpNameStepViewModel())
        }
    }
}
