struct DependencyInjector {
    private static var dependencyList: [String: Any] = [:]
    
    static func resolve<T>() -> T {
        guard let dependency = self.dependencyList[String(describing: T.self)] as? T else {
            fatalError("No provider registered for type \(T.self)")
        }
        return dependency
    }
    
    static func register<T>(dependency: T) {
        self.dependencyList[String(describing: T.self)] = dependency
    }
}

@propertyWrapper struct Injected<T> {
    var wrappedValue: T
    
    init() {
        self.wrappedValue = DependencyInjector.resolve()
    }
}

@propertyWrapper struct Provider<T> {
    var wrappedValue: T
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyInjector.register(dependency: wrappedValue)
    }
}
