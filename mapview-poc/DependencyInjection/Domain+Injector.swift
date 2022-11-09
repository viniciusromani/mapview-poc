struct DomainInjector {
    @Provider
    var getLocationsUseCase = GetLocationsUseCase()
    
    @Provider
    var storeUserUseCase = StoreUserCoreDataUseCase()
    
    @Provider
    var getUserUseCase = GetUserCoreDataUseCase()
    
    @Provider
    var deleteUserUseCase = DeleteUserCoreDataUseCase()
}
