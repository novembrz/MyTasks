//
//  RealmModel.swift
//  MyTasks
//
//  Created by Дарья on 14.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import RealmSwift

class RealmTask: Object{
    
    @objc dynamic var title = ""
    @objc dynamic var done = false
    
    convenience init(title: String, done: Bool) {
        self.init()
        self.title = title
        self.done = done
    }
}
