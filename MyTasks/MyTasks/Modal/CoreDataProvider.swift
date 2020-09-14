//
//  CoreDataProvider.swift
//  MyTasks
//
//  Created by Дарья on 14.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit
import CoreData

class CoreDataProvider {
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func taskFetchRequest() -> NSFetchRequest<Task> {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return fetchRequest
    }
}
