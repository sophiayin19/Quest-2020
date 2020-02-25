//
//  CoreDataStack.swift
//  TodoAppPrototype
//
//  Created by Sophia Yin on 2/20/20.
//  Copyright © 2020 Sophia Yin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack{
    var container: NSPersistentContainer{
        let container = NSPersistentContainer(name: "College")
        container.loadPersistentStores { (description, error) in
            guard error == nil else{
                print ("Error: \(error!)")
                return
            }
        }
        return container
    }
    
    var managedContext: NSManagedObjectContext {
        return container.viewContext
    }
}
