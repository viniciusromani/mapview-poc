import Foundation
import CoreData

extension Location {
    convenience init(model: LocationModel) {
        self.init(context: CoreDataManager.shared.context)
        self.title = model.title
        self.latitude = model.latitude
        self.longitude = model.longitude
    }
}
