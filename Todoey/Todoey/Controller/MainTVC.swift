//
//  MainTVC.swift
//  Todoey
//
//  Created by David E Bratton on 10/30/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController {

    var itemsArray = ["David Bratton", "Anna Bratton", "Nicholas Bratton", "Alexandra Bratton", "Lucy Bratton", "Marley Bratton", "Bailey Bratton"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)

        cell.textLabel?.text = itemsArray[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // PRINT ARRAY NUMBER
        print(indexPath.row)
        // PRINT ARRAY VALUE
        print(itemsArray[indexPath.row])
        // IF STATEMENT TO SET CHECKMARK ON SELECTED ROW
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        // MAKE ROW GO BACK TO WHITE AFTER CLICKED INSTEAD OF STAYING GREY
        tableView.deselectRow(at: indexPath, animated: true
            
        )
    }
   
    @IBAction func addToDoBtnPressed(_ sender: UIBarButtonItem) {
        // HAVE TO DECLARE VARIABLE TO HOLD THE TEXT FIELD
        var textField = UITextField()
        // BUILD ALERT
        let alert = UIAlertController(title: "Add New ToDoey", message: "", preferredStyle: .alert)
        // ADD TITLE AND THIS IS WHERE YOU HAVE TO ADD PRINT AND APPEND TO ARRAY
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if let newItem = textField.text {
                print("Added: \(newItem)")
                self.itemsArray.append(newItem)
                self.tableView.reloadData()
            }
        }
        // ADD TEXT BOX
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
