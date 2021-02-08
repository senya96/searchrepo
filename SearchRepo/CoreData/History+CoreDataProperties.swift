//
//  History+CoreDataProperties.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 08.02.2021.
//
//

import Foundation
import CoreData


extension History {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<History> {
        return NSFetchRequest<History>(entityName: "History")
    }

    @NSManaged public var date: Date?
    @NSManaged public var repository: Repository?

}

extension History : Identifiable {

}
