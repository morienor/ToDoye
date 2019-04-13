//
//  ViewController.swift
//  ToDoye
//
//  Created by AH on 31/03/2019.
//  Copyright © 2019 AH. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var item_array = [Item]()
    
    let data_file_path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    print(data_file_path)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let new_Item1 = Item()
        new_Item1.title = "find coffee"
        item_array.append(new_Item1)
        
        let new_Item2 = Item()
        new_Item2.title = "drink coffee"
        item_array.append(new_Item2)
        
        let new_Item3 = Item()
        new_Item3.title = "do stupid things faster"
        item_array.append(new_Item3)
        
        self.loadItems()
        
    }
    
    
    // this specifies how many cells are there
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item_array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // current item we are working with
        let item = item_array[indexPath.row]
    
        cell.textLabel?.text = item.title
        
        //Ternary operator
        
        cell.accessoryType =  item.done == true ? .checkmark : .none
        
        return cell
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(item_array[indexPath.row])
        
        item_array[indexPath.row].done = !item_array[indexPath.row].done
        
        self.saveItem()

        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "ADD new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the user ADD imte on the UIalert
            
            let new_Item_t = Item()
            new_Item_t.title = textField.text!
            self.item_array.append(new_Item_t)
            
            self.saveItem()
            
        }
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        present(alert, animated: true,completion: nil)
    }
    
    
    
    // this is saving at item to plis
    
    func saveItem() {
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(item_array)
            try data.write(to: data_file_path!)
        } catch {
            print("error encoding item array")
            
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
    // this is loading data from plis
    
    func loadItems() {
        
        
        if let data = try? Data(contentsOf: data_file_path!) {
            let decoder = PropertyListDecoder()
            
            do {
            item_array = try decoder.decode([Item].self, from: data)
            } catch {
                print("decoder error")
            }
        }
        
        
    }
    
    
}

