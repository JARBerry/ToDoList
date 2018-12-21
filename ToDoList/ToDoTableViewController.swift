//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Ray Berry on 20/12/2018.
//  Copyright © 2018 JARBerry. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController, ToDoCellDelegate {
    
    var todos = [ToDo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

        if let savedToDos = ToDo.loadToDos() {
            todos = savedToDos
        } else {
            todos = ToDo.loadSampleToDos()
        }
        
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return todos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier", for: indexPath) as! ToDoCell
        cell.delegate = self
        let todo = todos[indexPath.row]
        
        // Configure the cell...
        cell.titleLabel.text = todo.title
       cell.isCompleteButton.isSelected = todo.isComplete
        
        if cell.isCompleteButton.isSelected == true {
            cell.isCompleteButton.setImage(UIImage(named : "Checked"), for: .normal)
        }else {

            cell.isCompleteButton.setImage(UIImage(named : "Unchecked"), for: .normal)
        }
        
        
        
        
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDo.saveToDos(todos)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let todoViewController = segue.destination as! TodoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoViewController.todo = selectedTodo
        }
    }
    
    func checkmarkTapped(sender: ToDoCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
           todo.isComplete = !todo.isComplete
         
            
//            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
                ToDo.saveToDos(todos)
            
        }
        
    }
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let sourceViewController = segue.source as!
        TodoViewController
        
        if let todo = sourceViewController.todo {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                
            
            
            let newIndexPath = IndexPath (row: todos.count, section : 0)
            
            todos.append(todo)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        
             ToDo.saveToDos(todos)
        
    }
 

}
