//
//  TodoTableViewCell.swift
//  ToDoList
//
//  Created by Frezy Stone Mboumba on 7/2/16.
//  Copyright © 2016 Frezy Stone Mboumba. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var todoItemName: UILabel!
    @IBOutlet weak var todoDescriptionTextView: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        colorView.layer.cornerRadius = 10
    }


}
