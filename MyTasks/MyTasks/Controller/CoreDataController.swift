//
//  CoreDataController.swift
//  MyTasks
//
//  Created by Дарья on 14.09.2020.
//  Copyright © 2020 Дарья. All rights reserved.
//

import UIKit
import CoreData

class CoreDataController: UITableViewController {
    
    var tasks = CoreDataProvider.tasks

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
    }
    
    
    @IBAction func newTaskTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New Task", message: "Please add a new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                CoreDataProvider.saveTask(title: newTaskTitle)
                self.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func reloadData(){
        CoreDataProvider.taskFetchRequest()
        tasks = CoreDataProvider.tasks
        tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.isEmpty ? 0 : tasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coreCell", for: indexPath) as! CoreDataCell

        let task = tasks[indexPath.row]
        cell.taskLabel.text = task.title

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
    
    
    private func editTask(with editTitle: String){
        
        let newIndexPath = tableView.indexPathForSelectedRow!
        let task = tasks[newIndexPath.row]
        
        CoreDataProvider.editObject(editTask: task, newTask: editTitle)
    }
    
    
    // MARK: - Delete
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let task = tasks[indexPath.row]
            
            do{
                CoreDataProvider.deleteTask(task: task)
                reloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
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
            CoreDataProvider.editDone(editTask: task, newDone: done)
            completion(true)
        }
        
        action.backgroundColor = task.done ? .systemGreen : .systemGray
        action.image = UIImage(systemName: "checkmark.circle")
        
        return action
    }
    

}
