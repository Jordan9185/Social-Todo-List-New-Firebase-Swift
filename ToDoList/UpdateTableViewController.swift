//
//  UpdateTableViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 7/3/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class UpdateTableViewController: UITableViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var itemName: UITextField!
    
    var todo: Todo!
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        descriptionTextView.text = todo.content
        itemName.text = todo.title
        
    }
    
    
    @IBAction func updateAction(sender: AnyObject) {
                
        //Create the Colors for our Todo
      
        var title =  String()
        if itemName.text == ""{
            
            itemName.text = "No item name"
            title = itemName.text!
        }else{
            
            title = itemName.text!
        }
        
        var content = String()
        
        if descriptionTextView.text == "" {
            descriptionTextView.text = "No description for this Todo"
            content = descriptionTextView.text!
        }else{
            content = descriptionTextView.text!
        }
        
        
        
        
        
        let updatedTodo = Todo(title: title, content: content, username: FIRAuth.auth()!.currentUser!.displayName!, red: todo.red, blue: todo.blue, green: todo.green)
        
        let key = todo.ref!.key
        
        let updateRef = databaseRef.child("/allTodos/\(key)")
        
        updateRef.updateChildValues(updatedTodo.toAnyObject())
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
        
    }
    
    
}
