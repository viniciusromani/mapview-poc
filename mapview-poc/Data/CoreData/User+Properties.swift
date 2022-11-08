import Foundation
import CoreData

extension User {
    convenience init(model: UserModel) {
        self.init(context: CoreDataManager.shared.context)
        self.name = model.name
        self.location = Location(model: model.location)
    }
}
