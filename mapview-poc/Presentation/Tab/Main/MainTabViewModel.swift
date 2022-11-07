import SwiftUI

enum Screen: Int {
    case map
    case profile
    
    var next: Screen? {
        switch self {
        case .map: return .profile
        default: return nil
        }
    }
    
    var previous: Screen? {
        switch self {
        case .profile: return .map
        default: return nil
        }
    }
}

final class MainTabViewModel: ObservableObject {
    @Published
    var selected: Screen = .map
    
    func handleSwipe(_ value: CGFloat) {
        if let next = self.selected.next, value < -50 {
            self.selected = next
            return
        }
        
        if let previous = self.selected.previous, value > 50 {
            self.selected = previous
            return
        }
    }
}
