struct PresentationInjector {
    @Provider
    var getLocationsUseCase = GetLocationsUseCase() as GetLocationsUseCase
}
