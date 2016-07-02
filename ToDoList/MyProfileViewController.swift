//
//  MyProfileViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 7/1/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MyProfileViewController: UIViewController {

    @IBOutlet weak var userImageView: CustomizableImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var country: UITextField!
    var urlImage : String!
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorage! {
        return FIRStorage.storage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if FIRAuth.auth()?.currentUser == nil {
            
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            presentViewController(vc, animated: true, completion: nil)
        }
        else {
        databaseRef.child("users/\(FIRAuth.auth()!.currentUser!.uid)").observeEventType(.Value, withBlock: { (snapshot) in
            dispatch_async(dispatch_get_main_queue(), { 
                
                let user = User(snapshot: snapshot)
                self.username.text = user.username
                self.country.text = user.country
                self.email.text = user.email
                
                let imageUrl = String(user.photoUrl)
                
                self.storageRef.referenceForURL(imageUrl).dataWithMaxSize(1 * 1024 * 1024, completion: { (data, error) in
                    
                    if let error = error {
                        print(error.localizedDescription)
                    }else {
                        if let data = data {
                            self.userImageView.image = UIImage(data: data)
                        }
                    }
                })
                
            
                
                
                
            })
         
            
            }) { (error) in
                print(error.localizedDescription)
        }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
    
        if FIRAuth.auth()?.currentUser != nil {
        
        do {
            
     try  FIRAuth.auth()?.signOut()
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Login")
            presentViewController(vc, animated: true, completion: nil)
            
        } catch let error as NSError {
            print(error.localizedDescription)
            }
        }
    }

   

}
