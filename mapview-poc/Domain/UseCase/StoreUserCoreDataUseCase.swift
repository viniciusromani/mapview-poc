import Combine

class StoreUserCoreDataUseCase: UseCase {
    struct Params {
        private(set) var user: UserModel
    }
    @Injected
    private var dataSource: UserDataSource
    
    func execute(with params: Params?) -> AnyPublisher<Bool, Error> {
        let unwrapped = self.unwrapParams(params)
        return self.dataSource.store(unwrapped.user)
            .eraseToAnyPublisher()
    }
}
