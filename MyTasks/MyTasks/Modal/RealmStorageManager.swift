//
//  RealmStorageManager.swift
//  MyTasks
//
//  Created by Дарья on 14.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class RealmStorageManager {
    
    static var tasks: Results<RealmTask> {
        return realm.objects(RealmTask.self)
    }
    
    static func saveObject(_ task: RealmTask) {
        try! realm.write {
            realm.add(task)
        }
    }
    
    static func deleteObject(_ task: RealmTask) {
        try! realm.write {
            realm.delete(task)
        }
    }
    
    static func editObject(editTask: RealmTask, newTask: String){
            try! realm.write {
                editTask.title = newTask
            }
    }
    
    static func editDone(editTask: RealmTask, newDone: Bool){
        try! realm.write {
            editTask.done = newDone
        }
    }
}
