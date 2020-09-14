//
//  Persistance.swift
//  MyTasks
//
//  Created by Дарья on 14.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import Foundation

class Persistance {
    
    static let shared = Persistance()
    
    private let userNameKey = "Persistance.userNameKey"
    private let surnameKey = "Persistance.surnameKey"
    
    var userName: String? {
        set{
            UserDefaults.standard.set(newValue, forKey: userNameKey)
        }
        get{
            UserDefaults.standard.string(forKey: userNameKey)
        }
    }
    
    var surname: String? {
        set{
            UserDefaults.standard.set(newValue, forKey: surnameKey)
        }
        get{
            UserDefaults.standard.string(forKey: surnameKey)
        }
    }
    
}
