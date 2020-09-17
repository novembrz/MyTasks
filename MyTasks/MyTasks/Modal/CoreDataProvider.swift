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
    
    static var tasks: [Task] = []
    
    static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func fetchRequest() -> NSFetchRequest<Task> {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return fetchRequest
    }
    
    static func taskFetchRequest(){
        
        let context = CoreDataProvider.getContext()
        let fetchRequest = CoreDataProvider.fetchRequest()
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    static func saveTask(title: String){
        
        let context = CoreDataProvider.getContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            tasks.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    static func deleteTask(task: Task){
        
        let context = CoreDataProvider.getContext()
        let fetchRequest = CoreDataProvider.fetchRequest()
        
        if let fetchObj = try? context.fetch(fetchRequest) {
            for _ in fetchObj {
                context.delete(task)
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
