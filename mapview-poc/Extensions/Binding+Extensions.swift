import SwiftUI

extension Binding where Value == Bool {
    init(_ bool: Bool) {
        self.init(
            get: { bool },
            set: { _ in }
        )
    }
}
