//
//  UserTableViewCell.swift
//  PicShare
//
//  Created by Pablo Arango on 10/22/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class UserTableViewCell: PFTableViewCell  {
    
    
    
    

    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var actionButton: UIButton!
    
    var cellDelegate:UserTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonAction(sender: AnyObject) {
        
        if let delegate = cellDelegate {
            delegate.buttonAction(username.text!)
        }
        
    }
    
}

protocol UserTableViewCellDelegate {
    func buttonAction(username:String);
}
