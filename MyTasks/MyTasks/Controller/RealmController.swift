//
//  RealmController.swift
//  MyTasks
//
//  Created by Дарья on 14.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit
import RealmSwift

class RealmController: UITableViewController {
    
    private var tasks = RealmStorageManager.tasks

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = realm.objects(RealmTask.self)
        
    }

    @IBAction func newTaskTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New Task", message: "Please add a new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                self.saveNewTask(with: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveNewTask(with title: String){
        let newTask = RealmTask(title: title, done: false)
        RealmStorageManager.saveObject(newTask)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "realmCell", for: indexPath) as! RealmCell
        
        let task = tasks[indexPath.row]
        cell.taskLabel.text = task.title
        
        return cell
    }
    
    //Del
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = tasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            RealmStorageManager.deleteObject(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    //Done
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let task = tasks[indexPath.row]
//
//        let doneAction = UIContextualAction(style: .normal, title: "Done") { (action, view, completion) in
//
//            task.done = !(task.done)
//
//            if task.done == true {
//                action.backgroundColor = .systemGreen
//            } else {
//                action.backgroundColor = .systemGray
//            }
//            action.image = UIImage(systemName: "checkmark.circle")
//        }
//
//        return UISwipeActionsConfiguration(actions: [doneAction])
//    }
    
}
