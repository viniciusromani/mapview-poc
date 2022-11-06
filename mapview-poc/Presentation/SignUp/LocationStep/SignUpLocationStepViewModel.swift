import Foundation

final class SignUpLocationStepViewModel: ObservableObject {
    private let name: String
    @Published var location: String
    
    init(name: String,
         location: String = "") {
        self.name = name
        self.location = location
    }
}

extension SignUpLocationStepViewModel {
    var canSubmit: Bool {
        location.isNotEmpty
    }
}
