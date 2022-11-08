import Combine
import MapKit

/**
 TODO: Error treatment must be implemented
 */
class CoreDataUserDataSource: UserDataSource {
    @Injected private var manager: CoreDataManager
    
    func store(_ user: UserModel) -> Future<Bool, Error> {
        return Future { [weak self] in
            self?.manager.save()
            return true
        }
    }
    
    func get() -> Future<UserModel?, Error> {
        return Future { [weak self] in
            let request = User.fetchRequest()
            guard let managed = self?.manager.fetch(request)?.first as? User else {
                return nil
            }
            let model = UserModel(managed: managed)
            return model
        }
    }
}
