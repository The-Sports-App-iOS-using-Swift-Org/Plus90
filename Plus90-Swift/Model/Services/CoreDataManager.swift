//
//  CoreDataManager.swift
//  Plus90-Swift
//
//  Created by Bayoumi on 06/05/2026.
//

import CoreData
import UIKit

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

    func saveLeague(name: String, region: String, image: String) {
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteEntity", in: context)!
        let league = NSManagedObject(entity: entity, insertInto: context)
        
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
    // For Testing ( add favorites if its empty until handling leagues feature )
    func seedStaticFavorites() { // Called In AppDelegate
        let currentFavorites = fetchFavorites()
        
        guard currentFavorites.isEmpty else { return }
        
        let dummyData = [
            ("Premier League", "England", "onboarding1"),
            ("NBA", "United States", "onboarding1"),
            ("Champions League", "Europe", "onboarding1"),
            ("La Liga", "Spain", "onboarding1"),
            ("EuroLeague", "Europe", "onboarding1")
        ]
        
        for (name, region, image) in dummyData {
            saveLeague(name: name, region: region, image: image)
        }
        
        print("Static favorites seeded successfully.")
    }
}
