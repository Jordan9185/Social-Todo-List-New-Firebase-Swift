//
//  CommentTableViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 7/7/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FirebaseInstanceID
import FirebaseMessaging

class CommentTableViewController: UITableViewController {

    @IBOutlet weak var postContent: UITextView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    
    var databaseRef: FIRDatabaseReference!
    var storageRef: FIRStorageReference!
    
    var commentsArray = [Comment]()
    var selectedPost: Posts!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePost()
        
        let commentRef = self.selectedPost.ref!.child("comments")
        commentRef.observeEventType(.Value, withBlock: { (snapshot) in
            
            var newItems = [Comment]()
            
            for item in snapshot.children {
                
                let newTodo = Comment(snapshot: item as! FIRDataSnapshot)
                newItems.insert(newTodo, atIndex: 0)
                
            }
            self.commentsArray = newItems
            self.tableView.reloadData()
            
            }) { (error) in
                print(error.localizedDescription)
        }
        
    }
    
    
    
    
    
    func configurePost(){
        
        usernameLabel.text = selectedPost.username
        postContent.text = selectedPost.content
        
        storageRef = FIRStorage.storage().referenceForURL(selectedPost.userImageStringUrl)
        storageRef.dataWithMaxSize(1 * 1024 * 1024, completion: { (data, error) in
            
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), {
                    if let data = data {
                        self.userImageView.image = UIImage(data: data)
                    }
                    
                })
                
                
            }else {
                print(error!.localizedDescription)
                
            }
        })
        
        
        
        let storageRef2 = FIRStorage.storage().referenceForURL(selectedPost.postImageStringUrl)
        storageRef2.dataWithMaxSize(1 * 1024 * 1024, completion: { (data, error) in
            
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), {
                    if let data = data {
                        self.postImageView.image = UIImage(data: data)
                    }
                    
                })
                
                
            }else {
                print(error!.localizedDescription)
                
            }
        })
        
        
        
    }
    
    
    @IBAction func addCommentAction(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Comment", message: "Add a new comment", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textfield) in
            textfield.placeholder = "Add a new comment"
        }
        
        let sendCommentAction = UIAlertAction(title: "Comment", style: .Default) { (action) in
            let textfield = alertController.textFields!.first!
            
            let comment = Comment(postId: self.selectedPost.postId, userImageStringUrl: String(FIRAuth.auth()!.currentUser!.photoURL!), content: textfield.text!, username: FIRAuth.auth()!.currentUser!.displayName!)
            
            let commentRef = self.selectedPost.ref!.child("comments").childByAutoId()
            
            commentRef.setValue(comment.toAnyObject())
            
        }
        
FIRInstanceID.instanceID().getIDWithHandler { (string, error) in
    print(string)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        alertController.addAction(sendCommentAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        

    }
    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return commentsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! CommentTableViewCell

        // Configure the cell...
        
        cell.usernameLabel.text = commentsArray[indexPath.row].username
        cell.postContent.text = commentsArray[indexPath.row].content
        
        storageRef = FIRStorage.storage().referenceForURL(commentsArray[indexPath.row].userImageStringUrl)
        storageRef.dataWithMaxSize(1 * 1024 * 1024, completion: { (data, error) in
            
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), {
                    if let data = data {
                        cell.userImageView.image = UIImage(data: data)
                    }
                    
                })
                
                
            }else {
                print(error!.localizedDescription)
                
            }
        })


        return cell
    }
    

  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
