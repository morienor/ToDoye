//
//  ViewController.swift
//  ToDoye
//
//  Created by AH on 31/03/2019.
//  Copyright © 2019 AH. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let item_array = ["find coffee","drink coffee","do stupid things faster"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

}

