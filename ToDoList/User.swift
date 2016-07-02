//
//  User.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 7/1/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase


struct User {
    
    
    var username: String!
    var email: String!
    var photoUrl: String!
    var country: String!
    var ref: FIRDatabaseReference?
    var key: String
    
    init(snapshot: FIRDataSnapshot){
        
        key = snapshot.key
        username = snapshot.value!["username"] as! String
        email = snapshot.value!["email"] as! String
        photoUrl = snapshot.value!["photoUrl"] as! String
        country = snapshot.value!["country"] as! String
        ref = snapshot.ref
   
    }
    
    
    
}