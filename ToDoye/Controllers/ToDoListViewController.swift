//
//  ViewController.swift
//  ToDoye
//
//  Created by AH on 31/03/2019.
//  Copyright © 2019 AH. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var item_array = [Item]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    let data_file_path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    print(data_file_path)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        item_array.remove(at: indexPath.row)
        context.delete(item_array[indexPath.row])
        
//        item_array[indexPath.row].done = !item_array[indexPath.row].done
        
        self.saveItem()

        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    //MARK - add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "ADD new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the user ADD imte on the UIalert
            
            
        let new_Item_t = Item(context: self.context)
            
            new_Item_t.title = textField.text!
            new_Item_t.done = false
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

        do {
            try self.context.save()
        } catch {
            print("error saving context")

            
        }
        
        self.tableView.reloadData()
        
    }
    
    
    
    // this is loading data from plis
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest() ) {
        
        do {
          item_array = try context.fetch(request)
        } catch {
            print("request error \(error) ")
        }
        
    }
    
    
}

//MARK: search bar methods

extension ToDoListViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate  = NSPredicate.init(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            self.loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
        
    }
    
}

