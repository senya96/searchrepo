//
//  History+CoreDataClass.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 08.02.2021.
//
//

import Foundation
import CoreData

@objc(History)
public class History: NSManagedObject {
    class func newHistory(repository: Repository, context: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext) -> History{
        let newHistory = History(context: context)
        
        newHistory.date = Date()
        newHistory.repository = repository
        
        try? context.save()
        
        return newHistory
        
    }
}
