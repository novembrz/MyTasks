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
    
    
    private func editTask(with editTitle: String){
        
        let newIndexPath = tableView.indexPathForSelectedRow!
        let task = tasks[newIndexPath.row]
        
        RealmStorageManager.editObject(editTask: task, newTask: editTitle)
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "realmCell", for: indexPath) as! RealmCell
        
        let task = tasks[indexPath.row]
        cell.setInfo(task: task)
        
        return cell
    }
    
    // MARK: - Edit
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: "Edit Task", message: "Please edit your task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                self.editTask(with: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Delete
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let task = tasks[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in
            RealmStorageManager.deleteObject(task)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    // MARK: Task is done
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(indexPath: indexPath)
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    
    private func doneAction(indexPath: IndexPath) -> UIContextualAction{
        let task = tasks[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Избранное") { (action, view, completion) in
            let done = !task.done
            RealmStorageManager.editDone(editTask: task, newDone: done)
            completion(true)
        }
        
        action.backgroundColor = task.done ? .systemGreen : .systemGray
        action.image = UIImage(systemName: "checkmark.circle")
        
        return action
    }
    

    
}
