//
//  LogInViewController.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 6/29/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {

    @IBOutlet weak var passwordTextField: CustomizableTextField!
    @IBOutlet weak var emailTextField: CustomizableTextField!
    let networkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    @IBAction func unwindToLogIn(storyboard:UIStoryboardSegue){
    }
    
    
    
    @IBAction func logInAction(sender: AnyObject) {
        networkingService.signIn(emailTextField.text!, password: passwordTextField.text!)
        
    }
    
   
}
