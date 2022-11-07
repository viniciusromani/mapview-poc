struct DomainInjector {
    @Provider
    var localLocationDataSource: LocationDataSource = LocalLocationDataSource()
}
