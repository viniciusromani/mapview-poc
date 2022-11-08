struct DataInjector {
    @Provider
    var manager: CoreDataManager = CoreDataManager.shared
    
    @Provider
    var localLocationDataSource: LocationDataSource = LocalLocationDataSource()
    
    @Provider
    var userDataSource: UserDataSource = CoreDataUserDataSource()
}
