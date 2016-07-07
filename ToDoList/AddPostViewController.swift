//
//  AddPostTableViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 7/5/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase

class AddPostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

   
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    var databaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveButtonAction(sender: AnyObject) {
        
        let data = UIImageJPEGRepresentation(self.postImage.image!, 0.5)
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let postId = "\(FIRAuth.auth()!.currentUser!.uid)\(NSUUID().UUIDString)"
        let imagePath = "postImages\(postId)/postPic.jpg"
        
        storageRef.child(imagePath).putData(data!, metadata: metadata) { (metadata, error) in
            if error == nil {
                
                let postRef = self.databaseRef.child("posts").childByAutoId()
                let post = Posts(postImageStringUrl: String(metadata!.downloadURL()!), postId: postId, userImageStringUrl: String(FIRAuth.auth()!.currentUser!.photoURL!), content: self.textView.text!, username: FIRAuth.auth()!.currentUser!.displayName!)
                postRef.setValue(post.toAnyObject())
                
                
            }else {
                print(error!.localizedDescription)
            }
        }
        
        navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    
    
    @IBAction func chooseImage(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let alertController = UIAlertController(title: "Add a Picture", message: "Choose From", preferredStyle: .ActionSheet)
        
        let cameraAction = UIAlertAction(title: "Camera", style: .Default) { (action) in
            pickerController.sourceType = .Camera
            self.presentViewController(pickerController, animated: true, completion: nil)
            
        }
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .Default) { (action) in
            pickerController.sourceType = .PhotoLibrary
            self.presentViewController(pickerController, animated: true, completion: nil)
            
        }
        
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .Default) { (action) in
            pickerController.sourceType = .SavedPhotosAlbum
            self.presentViewController(pickerController, animated: true, completion: nil)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Destructive, handler: nil)
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        self.postImage.image = image
    }
    
    
    
    
    
    
    
    
    
    
    
}
