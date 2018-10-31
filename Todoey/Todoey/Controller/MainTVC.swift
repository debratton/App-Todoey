//
//  MainTVC.swift
//  Todoey
//
//  Created by David E Bratton on 10/30/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController {

//    var itemsArray = ["David Bratton", "Anna Bratton", "Nicholas Bratton", "Alexandra Bratton", "Lucy Bratton", "Marley Bratton", "Bailey Bratton"]
    //var itemsArray:[String] = []
    var itemsArray = [ToDo]()
   //let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ToDos.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(dataFilePath)
        
//        let newToDo1 = ToDo()
//        newToDo1.title = "David Bratton"
//        itemsArray.append(newToDo1)
//
//        let newToDo2 = ToDo()
//        newToDo2.title = "Anna Bratton"
//        itemsArray.append(newToDo2)
//
//        let newToDo3 = ToDo()
//        newToDo3.title = "Nicholas Bratton"
//        itemsArray.append(newToDo3)
//
//        let newToDo4 = ToDo()
//        newToDo4.title = "Alexandra Bratton"
//        itemsArray.append(newToDo4)
//
//        let newToDo5 = ToDo()
//        newToDo5.title = "Robert Bratton"
//        itemsArray.append(newToDo5)
        
        loadItems()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        // HAVE TO CHANGE THIS ONCE YOU USE CLASS MODEL
        //cell.textLabel?.text = itemsArray[indexPath.row]
        cell.textLabel?.text = itemsArray[indexPath.row].title
        
        if itemsArray[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
            
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // PRINT ARRAY NUMBER
        print(indexPath.row)
        // PRINT ARRAY VALUE
        print(itemsArray[indexPath.row])
        // IF STATEMENT TO SET CHECKMARK ON SELECTED ROW
        
        if itemsArray[indexPath.row].done == false {
            itemsArray[indexPath.row].done = true
        } else {
            itemsArray[indexPath.row].done = false
        }
        saveItems()

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
            let newToDo = ToDo()
            if let newItem = textField.text {
                newToDo.title = newItem
                self.itemsArray.append(newToDo)
                self.saveItems()
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
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            //let data = try encoder.encode(self.itemsArray)
            // HAVE TO GO TO ToDo Model and change class to ToDo:Encodable
            let data = try encoder.encode(itemsArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error Saving")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                //HAVE TO GO BACK TO ToDo.swift and ADD Decodable or
                //replace class ToDo: Codable
                itemsArray = try decoder.decode([ToDo].self, from: data)
                
            } catch {
                print("Error Retrieving \(error)")
            }
            
            
        }
    }
    
}
