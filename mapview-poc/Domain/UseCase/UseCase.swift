import Combine

protocol UseCase: ObservableObject {
    associatedtype Params
    associatedtype Model
    
    func execute(with params: Params?) async -> AnyPublisher<Model, Error>
}
extension UseCase {
    func unwrapParams(_ params: Params?) -> Params {
        guard let unwrapped = params else {
            fatalError("UseCase \(String(describing: self)) must have params")
        }
        return unwrapped
    }
}
