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
    
    let tasks = CoreDataProvider.tasks

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
        CoreDataProvider.taskFetchRequest()
    }
    
    
    @IBAction func newTaskTapped(_ sender: UIBarButtonItem) {
        
        let alertController = UIAlertController(title: "New Task", message: "Please add a new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let tf = alertController.textFields?.first
            if let newTaskTitle = tf?.text {
                CoreDataProvider.saveTask(title: newTaskTitle)
                self.tableView.reloadData()
            }
        }
        
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
 
    // MARK: - Delete
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let task = tasks[indexPath.row]
            
            do{
                CoreDataProvider.deleteTask(task: task)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.reloadData()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
        }
    }
    

}
