import Foundation

final class SignUpNameStepViewModel: ObservableObject {
    @Published var name: String
    
    init(name: String = "") {
        self.name = name
    }
}

extension SignUpNameStepViewModel {
    var canSubmit: Bool {
        self.name.isNotEmpty
    }
}
