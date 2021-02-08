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
        History.clean()
        
        return newHistory
        
    }
    
    class func clean(context: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext){
        let request = NSFetchRequest<History>(entityName: "History")

        let sd = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sd]

        guard let historyArray = try? CoreDataManager.sharedInstance.managedObjectContext.fetch(request) else {
            return
        }
            
        if historyArray.count > 20 {
            for i in 0...historyArray.count - 1 - 20 {
                context.delete(historyArray[i])
            }
        }
    }
    
    class func getAllHistory() -> [History]{
        let request = NSFetchRequest<History>(entityName: "History")

        let sd = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sd]

        let array = try? CoreDataManager.sharedInstance.managedObjectContext.fetch(request)

        if array != nil {
            return array!
        }

        return []
    }
}
