//
//  TodoListTableViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 6/29/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class TodoListTableViewController: UITableViewController {

    var todoArray = [Todo]()
    var databaseRef: FIRDatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        if FIRAuth.auth()?.currentUser == nil {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(vc, animated: true, completion: nil)
            
            
        } else {
       
        databaseRef = FIRDatabase.database().reference().child("allTodos")
        
        databaseRef.observeEventType(.Value, withBlock: { (snapshot) in
            
            var newItems = [Todo]()
            
            for item in snapshot.children {
                
                let newTodo = Todo(snapshot: item as! FIRDataSnapshot)
                newItems.insert(newTodo, atIndex: 0)
       
            }
            self.todoArray = newItems
            self.tableView.reloadData()
   
            }) { (error) in
                print(error.localizedDescription)
        }
        
        }
    }


    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TodoTableViewCell

        // Configure the cell...
        cell.todoItemName.text = todoArray[indexPath.row].title
        cell.todoDescriptionTextView.text = todoArray[indexPath.row].content
        cell.usernameLabel.text = todoArray[indexPath.row].username
        cell.colorView.backgroundColor = UIColor(red: todoArray[indexPath.row].red, green: todoArray[indexPath.row].green, blue: todoArray[indexPath.row].blue, alpha: 1.0)

        return cell
    }
    

   

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            // Delete the row from the data source
            let ref = todoArray[indexPath.row].ref
            ref!.removeValue()
            todoArray.removeAtIndex(indexPath.row)
           
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    


 

}
