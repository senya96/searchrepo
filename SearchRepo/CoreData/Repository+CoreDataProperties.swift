//
//  Repository+CoreDataProperties.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 08.02.2021.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var name: String?
    @NSManaged public var repo_description: String?
    @NSManaged public var url: String?
    @NSManaged public var history: History?

}

extension Repository : Identifiable {

}
