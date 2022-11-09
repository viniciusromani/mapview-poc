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
    
    func save() throws {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw error
            }
        }
    }
    
    func delete<T: NSManagedObject>(_ request: NSFetchRequest<T>) throws {
        do {
            let objects = try context.fetch(request)
            guard let toDelete = objects.first else {
                let error = NSError(domain: "", code: 0)
                throw error
            }
            context.delete(toDelete)
            try save()
        } catch {
            throw error
        }
    }
}
