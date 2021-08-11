//
//  MemoryManager.swift
//  Cats
//
//  Created by Дмитрий Юдин on 10.08.2021.
//

import UIKit
import CoreData

protocol MemoryProtocol: AnyObject {
    func fetch() -> [Cat]?
    func save(cat: Cat)
    func saveContext()
}

class MemoryService: MemoryProtocol {
    
    var persistentContainer: NSPersistentContainer {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { fatalError("Could not convert delegate to AppDelegate") }
        return appDelegate.persistentContainer
    }
    
    lazy var managedObjectContext = persistentContainer.viewContext
    
    func fetch() -> [Cat]? {
        var catsEntity: [CatsEntity]?
        
        catsEntity = try? managedObjectContext.fetch(CatsEntity.fetchRequest())
        if catsEntity != nil {
            var cats = [Cat]()
            for cat in catsEntity! {
                cats.append(Cat(image: UIImage(data: cat.image!)!, breeds: []))
            }
            
            print(cats)
            return cats
        }
        return nil
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
}



