import CoreData


let kMapApp = "MapApp"

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: kMapApp)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func fetch<T: NSManagedObject>() -> [T]? {
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        
        do {
            let fetched = try container.viewContext.fetch(request)
            return fetched
        } catch {
            print("Error fetching data from \(T.self) in CoreData \(error.localizedDescription)")
            return nil
        }
    }
    
    func save<T: NSManagedObject>(_ t: T) {
        let entity = T(context: container.viewContext)
        self.store()
    }
    
    private func store() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let err = error as NSError
                fatalError("Unresolved error \(err.localizedDescription)")
            }
        }
    }
}
