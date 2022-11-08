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
    
    lazy var context: NSManagedObjectContext = {
        return container.viewContext
    }()
    
    func fetch<T: NSManagedObject>(_ request: NSFetchRequest<T>) -> [T]? {
        do {
            let fetched = try container.viewContext.fetch(request)
            return fetched
        } catch {
            print("Error fetching data from \(T.self) in CoreData \(error.localizedDescription)")
            return nil
        }
    }
    
    func save() {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let err = error as NSError
                fatalError("Unresolved error \(err.localizedDescription)")
            }
        }
    }
}
