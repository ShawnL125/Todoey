//
//  ViewController.swift
//  Todoey
//
//  Created by Shawn on 2018/9/3.
//  Copyright © 2018年 Shawn. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Send Applications"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Join Interview"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Get Offer"
        itemArray.append(newItem2)
        
        
        // Reload the data from documention that sorting by ToDoListArray for forKey
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
    }

    //MARK - TableView Datasource Methods
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        // Set the check mark when item stutas is done
        cell.accessoryType = item.done ? .checkmark : .none
       
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Reverse the status of item after clicking item
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
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
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
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

