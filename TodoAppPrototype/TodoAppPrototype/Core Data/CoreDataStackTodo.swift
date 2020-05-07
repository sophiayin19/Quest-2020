//
//  CoreDataStackTodo.swift
//  QuestPrototype1
//
//  Created by Sophia Yin on 5/6/20.
//  Copyright © 2020 Sophia Yin. All rights reserved.
//

import Foundation
import CoreData
class CoreDataStackTodo {
    var container: NSPersistentContainer {
        let container = NSPersistentContainer(name:"Todos")
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
    

