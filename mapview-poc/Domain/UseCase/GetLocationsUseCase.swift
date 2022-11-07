import Combine
import MapKit

/**
 For the sake of simplicity, we avoided creating
 a repository layer as Clean Architecture preachs.
 
 There is no need for that since we dont have any
 logic regarding the data. We only fetch and display it.
 */
class GetLocationsUseCase: UseCase {
    struct Params {
        private(set) var text: String
    }
    @Injected
    private var dataSource: LocationDataSource
    
    func execute(with params: Params?) async -> AnyPublisher<[LocationModel], Error> {
        let unwrapped = self.unwrapParams(params)
        return await self.dataSource.search(unwrapped.text)
            .map { mapItems -> [LocationModel] in
                mapItems.map(LocationModel.init)
            }.eraseToAnyPublisher()
    }
}
