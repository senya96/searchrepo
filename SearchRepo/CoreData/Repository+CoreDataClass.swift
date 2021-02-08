//
//  Repository+CoreDataClass.swift
//  SearchRepo
//
//  Created by Сергій Насінник on 08.02.2021.
//
//

import Foundation
import CoreData

@objc(Repository)
public class Repository: NSManagedObject {
    class func newRepository(name: String, url: String, repo_description: String, context: NSManagedObjectContext = CoreDataManager.sharedInstance.managedObjectContext) -> Repository{
        let newRepository = Repository(context: context)
        
        newRepository.name = name
        newRepository.url = url
        newRepository.repo_description = repo_description
        
        try? context.save()
        
        return newRepository
        
    }
    
    class func getRepositoryBy(_ url: String) -> Repository?{

        let request = NSFetchRequest<Repository>(entityName: "Repository")
        request.predicate = NSPredicate(format: "url == %@", url as CVarArg)
        request.fetchLimit = 1
        

        guard let array = try? CoreDataManager.sharedInstance.managedObjectContext.fetch(request) else { return nil }
        
        if array.count > 0 {
            return array[0]
        }

        return nil
    }
}
