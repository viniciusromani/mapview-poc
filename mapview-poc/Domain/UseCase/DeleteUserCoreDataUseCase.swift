import Combine

class DeleteUserCoreDataUseCase: UseCase {
    struct Params {
        private(set) var user: UserModel
    }
    @Injected
    private var dataSource: UserDataSource
    
    func execute(with params: Params?) -> AnyPublisher<Bool, Error> {
        let unwrapped = self.unwrapParams(params)
        return self.dataSource.delete(unwrapped.user)
            .eraseToAnyPublisher()
    }
}
