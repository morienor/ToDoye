//
//  ViewController.swift
//  ToDoye
//
//  Created by AH on 31/03/2019.
//  Copyright © 2019 AH. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var item_array = ["find coffee","drink coffee","do stupid things faster"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "to_do_list_array") as? [String] {
            item_array = items
        }
    }
    
    
    // this specifies how many cells are there
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item_array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    
        cell.textLabel?.text = item_array[indexPath.row]
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(item_array[indexPath.row])

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "ADD new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the user ADD imte on the UIalert
            
            self.defaults.set(self.item_array, forKey: "to_do_list_array")
            self.item_array.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        present(alert, animated: true,completion: nil)
    }
    
}

