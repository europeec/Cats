//
//  CatsEntity+CoreDataProperties.swift
//  Cats
//
//  Created by Дмитрий Юдин on 11.08.2021.
//
//

import Foundation
import CoreData


extension CatsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CatsEntity> {
        return NSFetchRequest<CatsEntity>(entityName: "CatsEntity")
    }

    @NSManaged public var image: Data?

}

extension CatsEntity: Identifiable {

}
