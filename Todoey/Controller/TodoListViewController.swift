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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the data from documentDirectory
        loadItemData()
        
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
        
        saveItemData()
        
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
            
            self.saveItemData()
            
            
        }
        
        // TextField in alert window
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    // Save Item data on documentDirectory
    func saveItemData() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        // Reload the Data inside array and change the view of row
        self.tableView.reloadData()
    }
    
    func loadItemData() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}

