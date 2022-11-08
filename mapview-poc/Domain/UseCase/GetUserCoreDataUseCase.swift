import Combine

class GetUserCoreDataUseCase: UseCase {
    @Injected
    private var dataSource: UserDataSource
    
    func execute(with params: Void? = nil) async -> AnyPublisher<UserModel, Error> {
        return self.dataSource.get()
            .eraseToAnyPublisher()
    }
}
