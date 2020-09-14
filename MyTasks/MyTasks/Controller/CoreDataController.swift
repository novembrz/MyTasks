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
    
    var tasks: [Task] = []
    var context = CoreDataProvider.getContext()
    var fetchRequest = CoreDataProvider.taskFetchRequest()
    
    var taskObj: Task!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    @IBAction func newTaskTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New Task", message: "Please add a new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                self.saveTask(withTitle: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func saveTask(withTitle title: String) {

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
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coreCell", for: indexPath)

        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.title

        return cell
    }
    
    // MARK: - Done
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        
        return UISwipeActionsConfiguration(actions: [done])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction{
        
        let task = tasks[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Done") { (action, view, completion) in
            
            self.taskObj.done = true
            self.tasks[indexPath.row] = task
            
            do {
                try self.context.save()
                self.tableView.reloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            completion(true)
        }
        
        if taskObj.done == true {
            action.backgroundColor = .systemGreen
        } else {
            action.backgroundColor = .systemGray
        }
        action.image = UIImage(systemName: "checkmark.circle")
        
        return action
    }

 
    // MARK: - Delete
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let task = tasks[indexPath.row]
            
            if let fetchObj = try? context.fetch(fetchRequest) {
                for _ in fetchObj {
                    context.delete(task)
                }
            }
            
            do {
                try context.save()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
//            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

}
