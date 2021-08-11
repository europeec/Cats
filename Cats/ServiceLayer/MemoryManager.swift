//
//  MemoryManager.swift
//  Cats
//
//  Created by Дмитрий Юдин on 10.08.2021.
//

import UIKit
import CoreData

protocol MemoryProtocol: AnyObject {
    var catsEntity: [CatsEntity]? { get set }
    func fetch() -> [CatsEntity]?
    func save(cat: Cat)
    func saveContext()
    func remove(catEntity: CatsEntity)
    func cleanCoreData()
    func convert(entity: CatsEntity?) -> Cat?
    func convertArray(entityArray: [CatsEntity]?) -> [Cat]?
}

class MemoryService: MemoryProtocol {
    var catsEntity: [CatsEntity]?
    
    static let shared = MemoryService()
    
    var persistentContainer: NSPersistentContainer {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Could not convert delegate to AppDelegate") }
        return appDelegate.persistentContainer
    }
    
    lazy var managedObjectContext = persistentContainer.viewContext
    
    func fetch() -> [CatsEntity]? {
        catsEntity = try? managedObjectContext.fetch(CatsEntity.fetchRequest())
        return catsEntity
    }
    
    func save(cat: Cat) {
        let newCat = CatsEntity(context: managedObjectContext)
        newCat.image = cat.image.pngData()
        self.saveContext()
    }
    
    func saveContext() {
            if self.managedObjectContext.hasChanges {
                do {
                    try self.managedObjectContext.save()
                }
                catch let error as NSError? {
                    print("Error saveContext: \(error!), userInfo: \(error!.userInfo)")
                }
            }
        }
    
    func remove(catEntity: CatsEntity) {
        managedObjectContext.delete(catEntity)
        saveContext()
    }
    
    func cleanCoreData() {
        catsEntity = fetch()
        guard let catsEntity = catsEntity else { return }
        for item in catsEntity {
            remove(catEntity: item)
        }
        saveContext()
        self.catsEntity = nil
    }
    
    // converting CatEntity? to Cat?
    func convert(entity: CatsEntity?) -> Cat? {
        guard let entity = entity else { return nil }
        return Cat(image: UIImage(data: entity.image!)!, breeds: [])
    }
    
    func convertArray(entityArray: [CatsEntity]?) -> [Cat]? {
        guard let entityArray = entityArray else { return nil }
        var cats = [Cat]()
        for item in entityArray {
            cats.append(convert(entity: item)!)
        }
        return cats
    }
}



