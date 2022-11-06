import SwiftUI

public protocol NavigationRouter {
    associatedtype V: View
    
    var transition: NavigationTransitionStyle { get }
    
    @ViewBuilder
    func view() -> V
}
