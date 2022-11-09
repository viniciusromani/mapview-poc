import Combine
import MapKit

/**
 TODO: Error treatment must be implemented
 */
class CoreDataUserDataSource: UserDataSource {
    @Injected private var manager: CoreDataManager
    
    func store(_ user: UserModel) -> Future<Bool, Error> {
        return Future { [weak self] in
            try self?.manager.save()
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
    
    func delete(_ user: UserModel) -> Future<Bool, Error> {
        return Future { [weak self] in
            let request = User.fetchRequest()
            request.predicate = NSPredicate(format: "name = %@", user.name)
            try self?.manager.delete(request)
            return true
        }
    }
}
