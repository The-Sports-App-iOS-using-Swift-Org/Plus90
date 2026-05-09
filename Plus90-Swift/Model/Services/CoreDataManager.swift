//
//  CoreDataManager.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 06/05/2026.
//

import CoreData
import UIKit
//Model/Services/CoreDataManager
class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Plus90_Swift") 
        container.loadPersistentStores { _, error in
            if let error = error { fatalError("Unresolved error \(error)") }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveLeague(id : Int64 ,name: String, region: String, image: String) {
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteEntity", in: context)!
        let league = NSManagedObject(entity: entity, insertInto: context)
        league.setValue(id, forKey: "id")
        league.setValue(name, forKey: "name")
        league.setValue(region, forKey: "region")
        league.setValue(image, forKey: "imageName")

        saveContext()
    }

    func fetchFavorites() -> [FavoriteLeague] {
        let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
        do {
            let result = try context.fetch(request)
            return result.map {
                FavoriteLeague(
                    id : $0.value(forKey: "id") as? Int64 ?? 0,
                    name: $0.value(forKey: "name") as? String ?? "",
                    region: $0.value(forKey: "region") as? String ?? "",
                    imageName: $0.value(forKey: "imageName") as? String ?? ""
                )
            }
        } catch {
            return []
        }
    }

    func deleteLeague(name: String) {
        let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
        request.predicate = NSPredicate(format: "name == %@", name)
        
        if let result = try? context.fetch(request) {
            for object in result {
                context.delete(object)
            }
            saveContext()
        }
    }

    private func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }

    func isLeagueFavorite(name: String) -> Bool {
        let request = NSFetchRequest<NSManagedObject>(entityName: "FavoriteEntity")
        request.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            return false
        }
    }
    
}
