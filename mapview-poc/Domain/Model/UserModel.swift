import CoreData

class UserModel {
    private(set) var name: String
    private(set) var location: LocationModel
    
    init(name: String,
         location: LocationModel) {
        self.name = name
        self.location = location
    }
    
    init(managed: User) {
        self.name = managed.name ?? ""
        self.location = managed.location != nil ? LocationModel(managed: managed.location!): LocationModel()
    }
}
