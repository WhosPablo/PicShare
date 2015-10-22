//
//  UserViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/16/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//

import Parse
import Foundation

class UserViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.topItem?.title = PFUser.currentUser()?.username
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutAction(sender: AnyObject) {
        
        PFUser.logOut()
        self.performSegueWithIdentifier("logOutDone", sender: self)
    }
}