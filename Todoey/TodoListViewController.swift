//
//  ViewController.swift
//  Todoey
//
//  Created by Shawn on 2018/9/3.
//  Copyright © 2018年 Shawn. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Egges", "Destory Demogorgon"]
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Reload the data from documention that sorting by ToDoListArray for forKey
        if let items = UserDefaults.standard.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
    }

    //MARK - TableView Datasource Methods
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // Set checkmark when click row
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        // Flash when selecting row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        // Display the alert windows
        let alert = UIAlertController(title: "Add New todoey Item", message: "", preferredStyle: .alert)
        
        // It will happens when user clicks on Add item button
        let action = UIAlertAction(title: "Add item", style: .default) {(action) in
            
            self.itemArray.append(textField.text!)
            // Set the defaults documentation for store the array and call it when app started
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            // Reload the Data inside array and change the view of row
            self.tableView.reloadData()
        }
        
        // TextField in alert window
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

