//
//  AddTodoViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 6/29/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class AddTodoTableViewController: UITableViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var itemName: UITextField!
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func saveAction(sender: AnyObject) {
    
        // Create Todo Reference in the FirDatabase
        let todoRef = databaseRef.child("allTodos").childByAutoId()
        
        //Create the Colors for our Todo
    
        let red = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
        let blue = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5
        let green = CGFloat(arc4random_uniform(UInt32(255.5)))/255.5

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
        
        
        
        
        
        let todo = Todo(title: title, content: content, username: FIRAuth.auth()!.currentUser!.displayName!, red: red, blue: blue, green: green)
        
        todoRef.setValue(todo.toAnyObject())
        
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
