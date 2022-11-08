import Combine
import MapKit

/**
 TODO: Error treatment must be implemented
 */
class CoreDataUserDataSource: UserDataSource {
    @Injected private var manager: CoreDataManager
    
    func store(_ user: UserModel) -> Future<Bool, Error> {
        return Future { [weak self] in
            let managedUser = User()
            managedUser.name = user.name
            let location = Location()
            location.title = user.location.title
            location.latitude = user.location.latitude
            location.longitude = user.location.longitude
            managedUser.location = location
            self?.manager.save(managedUser)
            return true
        }
    }
    
    func get() -> Future<UserModel, Error> {
        return Future { [weak self] in
            guard let managedUser = self?.manager.fetch()?.first as? User,
                    let location = managedUser.location else {
                print("Could not get User from CoreData")
                return
            }
            let model = UserModel(managed: managedUser)
            return model
        }
    }
}
